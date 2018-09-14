#!/bin/bash

# Multi-Task Kaldi // Josh Meyer (2018) // jrmeyer.github.io
# original multi-lingual babel scripts from Pegah Ghahremani

# REQUIRED:
#
#    (1) baseline PLP features, and models (tri or mono) alignment (e.g. tri_ali or mono_ali)
#        for all tasks
#    (2) input data (audio, lm, etc)
#
# This script can be used for training multi-task setup using different
# tasks with no shared phones.
#
# It will generate separate egs directory for each dataset and combine them
# during training.
#
# In the multi-task training setup, mini-batches of data corresponding to
# different tasks are randomly combined to generate egs.*.scp files
# using steps/nnet3/multilingual/combine_egs.sh and generated egs.*.scp files
#
# For all tasks, we share all except last hidden layer and there is separate final
# layer per task.
#
# This script does not use ivectors or bottleneck feats
#
#







### STAGES
##
#

config_nnet=1
make_egs=0
combine_egs=1
train_nnet=1
make_copies_nnet=1
decode_test=1

#
##
###

set -e


. ./path.sh
. ./utils/parse_options.sh


task_list=($1) # space-delimited list of input_dir names
typo_list=($2) # space-delimited list of "mono" or "tri"
task2weight=$3 # comma-delimited list of weights for target-vectors
hidden_dim=$4  # number of hidden dimensions in NNET
num_epochs=$5  # number of epochs through data
main_dir=$6    # location of /data and /exp dir (probably "MTL")



cmd="utils/run.pl"

exp_dir=$main_dir/exp/nnet3/multitask
master_egs_dir=$exp_dir/egs
num_tasks=${#task_list[@]}





if [ 1 ]; then

    #########################################
    ### SET VARIABLE NAMES AND PRINT INFO ###
    #########################################
    
    # Check data files from each task
    # using ${typo_list[$i]}_ali for alignment dir
    for i in `seq 0 $[$num_tasks-1]`; do
        for f in $main_dir/data/${task_list[$i]}/train/{feats.scp,text} \
                      $main_dir/exp/${task_list[$i]}/${typo_list[$i]}_ali/ali.1.gz \
                      $main_dir/exp/${task_list[$i]}/${typo_list[$i]}_ali/tree; do
            [ ! -f $f ] && echo "$0: no such file $f" && exit 1;
        done
    done
    
    # Make lists of dirs for tasks
    for i in `seq 0 $[$num_tasks-1]`; do
        multi_data_dirs[$i]=$main_dir/data/${task_list[$i]}/train
        multi_egs_dirs[$i]=$main_dir/exp/${task_list[$i]}/nnet3/egs
        multi_ali_dirs[$i]=$main_dir/exp/${task_list[$i]}/${typo_list[$i]}_ali
    done

    num_targets_list=()
    for i in `seq 0 $[$num_tasks-1]`;do

        num_targets=`tree-info ${multi_ali_dirs[$i]}/tree 2>/dev/null | grep num-pdfs | awk '{print $2}'` || exit 1;
	num_targets_list[$i]=$num_targets
	
        echo ""
        echo "###### BEGIN TASK INFO ######"
        echo "task= ${task_list[$i]}"
        echo "num_targets= $num_targets"
        echo "data_dir= ${multi_data_dirs[$i]}"
        echo "ali_dir= ${multi_ali_dirs[$i]}"
        echo "egs_dir= ${multi_egs_dirs[$i]}"
        echo "###### END TASK INFO ######"
        echo ""

    done
fi




if [ "$config_nnet" -eq "1" ]; then

    echo "### ============================ ###";
    echo "### CREATE CONFIG FILES FOR NNET ###";
    echo "### ============================ ###";

    ## Remove old generated files
    # rm -rf $exp_dir
    # for i in `seq 0 $[$num_tasks-1]`; do
    #     rm -rf exp/${task_list[$i]}/nnet3
    # done

    mkdir -p $exp_dir/configs

    feat_dim=`feat-to-dim scp:${multi_data_dirs[0]}/feats.scp -`

    hidden_dim=$hidden_dim
    # The following definition is for the shared hidden layers of the nnet!
    cat <<EOF > $exp_dir/configs/network.xconfig
input dim=$feat_dim name=input
relu-renorm-layer name=tdnn1 input=Append(input@-2,input@-1,input,input@1,input@2) dim=$hidden_dim
relu-renorm-layer name=tdnn2 dim=$hidden_dim
relu-renorm-layer name=tdnn3 input=Append(-1,2) dim=$hidden_dim
relu-renorm-layer name=tdnn4 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn5 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn6 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn7 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn8 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn9 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn10 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnn11 input=Append(-3,3) dim=$hidden_dim
relu-renorm-layer name=tdnnFINAL input=Append(-3,3) dim=$hidden_dim
# adding the layers for diffrent task's output
EOF
    
    # Create separate outptut layer and softmax for all tasks.
    
    for i in `seq 0 $[$num_tasks-1]`;do

        num_targets=`tree-info ${multi_ali_dirs[$i]}/tree 2>/dev/null | grep num-pdfs | awk '{print $2}'` || exit 1;
	
        echo " relu-renorm-layer name=prefinal-affine-task-${i} input=tdnnFINAL dim=$hidden_dim"
        echo " output-layer name=output-${i} dim=$num_targets max-change=1.5"
        
    done >> $exp_dir/configs/network.xconfig
    
    steps/nnet3/xconfig_to_configs.py \
        --xconfig-file $exp_dir/configs/network.xconfig \
        --config-dir $exp_dir/configs/ \
        --nnet-edits="rename-node old-name=output-0 new-name=output"

fi




if [ "$make_egs" -eq "1" ]; then
        
    echo "### ====================================== ###"
    echo "### MAKE INDIVIDUAL NNET3 EGS DIR per TASK ###"
    echo "### ====================================== ###"


    echo "### MAKE SEPARATE EGS DIR PER TASK ###"
    
    local/nnet3/prepare_multilingual_egs.sh \
        --cmd "$cmd" \
        --cmvn-opts "--norm-means=false --norm-vars=false" \
        --left-context 30 \
        --right-context 31 \
        $num_tasks \
        ${multi_data_dirs[@]} \
        ${multi_ali_dirs[@]} \
        ${multi_egs_dirs[@]} \
        ${num_targets_list[@]} \
        || exit 1;

fi



if [ "$combine_egs" -eq "1" ]; then

    echo "### ====================================== ###"
    echo "### COMBINE ALL TASKS EGS INTO ONE BIG DIR ###"
    echo "### ====================================== ###"
    
    steps/nnet3/multilingual/combine_egs.sh \
        --cmd "$cmd" \
        --lang2weight $task2weight \
        $num_tasks \
        ${multi_egs_dirs[@]} \
        $master_egs_dir \
        || exit 1;

fi



if [ "$train_nnet" -eq "1" ]; then

    echo "### ================ ###"
    echo "### BEGIN TRAIN NNET ###"
    echo "### ================ ###"

    steps/nnet3/train_raw_dnn.py \
        --stage=-5 \
        --cmd="$cmd" \
        --trainer.num-epochs $num_epochs \
        --trainer.optimization.num-jobs-initial=1 \
        --trainer.optimization.num-jobs-final=1 \
        --trainer.optimization.initial-effective-lrate=0.0015 \
        --trainer.optimization.final-effective-lrate=0.00015 \
        --trainer.optimization.minibatch-size=256,128 \
        --trainer.samples-per-iter=10000 \
        --trainer.max-param-change=2.0 \
        --trainer.srand=0 \
        --feat.cmvn-opts="--norm-means=false --norm-vars=false" \
        --feat-dir ${multi_data_dirs[0]} \
        --egs.dir $master_egs_dir \
        --use-dense-targets false \
        --targets-scp ${multi_ali_dirs[0]} \
        --cleanup.remove-egs true \
        --use-gpu true \
        --dir=$exp_dir  \
        || exit 1;
    

    
    ### Print training info ###
    cat_tasks=""
    cat_typos=""
    for i in `seq 0 $[$num_tasks-1]`; do
        cat_tasks="${cat_tasks}_${task_list[$i]}"
        cat_typos="${cat_typos}_${typo_list[$i]}"
    done
    
    # Get training ACC in right format for plotting
    utils/format_accuracy_for_plot.sh "$main_dir/exp/nnet3/multitask/log" "ACC_nnet3_multitask${cat_tasks}${cat_typos}.txt";



    echo "### ============== ###"
    echo "### END TRAIN NNET ###"
    echo "### ============== ###"

fi




if [ "$make_copies_nnet" -eq "1" ]; then

    echo "### ========================== ###"
    echo "### SPLIT & COPY NNET PER TASK ###"
    echo "### ========================== ###"
    
    for i in `seq 0 $[$num_tasks-1]`;do
        task_dir=$exp_dir/${task_list[$i]}
        
        mkdir -p $task_dir
        
        echo "$0: rename output name for each task to 'output' and "
        echo "add transition model."
        
        nnet3-copy \
            --edits="rename-node old-name=output-$i new-name=output" \
            $exp_dir/final.raw \
            - | \
            nnet3-am-init \
                ${multi_ali_dirs[$i]}/final.mdl \
                - \
                $task_dir/final.mdl \
            || exit 1;
        
        cp $exp_dir/cmvn_opts $task_dir/cmvn_opts || exit 1;
        
        echo "$0: compute average posterior and readjust priors for task ${task_list[$i]}."
        
        steps/nnet3/adjust_priors.sh \
            --cmd "$cmd" \
            --use-gpu true \
            --iter "final" \
            --use-raw-nnet false \
            $task_dir ${multi_egs_dirs[$i]} \
            || exit 1;
    done
fi





if [ "$decode_test" -eq "1" ]; then

    echo "### ============== ###"
    echo "### BEGIN DECODING ###"
    echo "### ============== ###"

    if [ "${typo_list[0]}" == "mono" ]; then
        echo "Decoding with monophone graph, make sure you compiled"
        echo "it with mkgraph.sh --mono (the flag is important!)"
    fi
    
    test_data_dir=data_${task_list[0]}/test
    graph_dir=exp_${task_list[0]}/${typo_list[0]}phones/graph
    decode_dir=${exp_dir}/decode
    final_model=${exp_dir}/${task_list[0]}/final_adj.mdl
    
    mkdir -p $decode_dir

    unknown_phone="SPOKEN_NOISE"
    silence_phone="SIL"

    echo "### decoding with $( `nproc` ) jobs, unigram LM ###"
    
    steps/nnet3/decode.sh \
        --nj `nproc` \
        --cmd $cmd \
        --max-active 250 \
        --min-active 100 \
        $graph_dir \
        $test_data_dir\
        $decode_dir \
        $final_model \
        $unknown_phone \
        $silence_phone \
        | tee $decode_dir/decode.log

    printf "\n#### BEGIN CALCULATE WER ####\n";

    # Concatenate tasks to for WER filename
    cat_tasks=""
    cat_typos=""
    for i in `seq 0 $[$num_tasks-1]`; do
        cat_tasks="${cat_tasks}_${task_list[$i]}"
        cat_typos="${cat_typos}_${typo_list[$i]}"
    done
    
    for x in ${decode_dir}*; do
        [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh > WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    done


    echo "hidden_dim=$hidden_dim"  >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    echo "num_epochs=$num_epochs"  >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    echo "task2weight=$task2weight" >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;

    echo ""  >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;

    echo "test_data_dir=$test_data_dir" >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    echo "graph_dir=$graph_dir" >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    echo "decode_dir=$decode_dir" >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    echo "final_model=$final_model" >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    
    
    for i in `seq 0 $[$num_tasks-1]`;do
        
        num_targets=${num_targets_list[$i]}

        num_targets=`tree-info ${multi_ali_dirs[$i]}/tree 2>/dev/null | grep num-pdfs | awk '{print $2}'` || exit 1;
        
        echo "
    ###### BEGIN TASK INFO ######
    task= ${task_list[$i]}
    num_targets= $num_targets
    data_dir= ${multi_data_dirs[$i]}
    ali_dir= ${multi_ali_dirs[$i]}
    egs_dir= ${multi_egs_dirs[$i]}
    ###### END TASK INFO ######
    " >> WER_nnet3_multitask${cat_tasks}${cat_typos}.txt;
    done

    echo "###==============###"
    echo "### END DECODING ###"
    echo "###==============###"

fi

