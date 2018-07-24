#!/bin/bash

dim=256
num_epochs=1
main_dir=MTL








# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-15min-org" "tri" "1.0" $dim $num_epochs $main_dir

#rm -rf MTL/exp/nnet3
#./run_nnet3_multitask.sh "atai-15min-org atai-15min-mod" "tri tri" "1.0,1.0" $dim $num_epochs $main_dir



# rm -rf /data/MTL/exp/nnet3

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-15min-org" "tri" "1.0" $dim $num_epochs $main_dir
# # rm -rf /data/MTL/exp/nnet3

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100A-org" "tri" "1.0" $dim $num_epochs $main_dir

exit

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100A-org atai-100B-org" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100B-org" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100C-org" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100D-org" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100E-org" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100F-org" "tri" "1.0" $dim $num_epochs $main_dir



# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100A-org atai-100A-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100B-org atai-100B-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100C-org atai-100C-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100D-org atai-100D-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100E-org atai-100E-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100F-org atai-100F-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir


# sudo shutdown now
exit
