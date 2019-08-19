## Joshua Meyer 2018
##
## format logged training data from compute_prob_valid.* and
## compute_prob_train.* so that the scipt utils/plot_accuracy.py
## and matplotlib can work with it.

LOGDIR=$1
NNET=$2
OUTPUT=$3

if [ $NNET == "nnet2" ]; then
    ## NNET2 ##
    # loop over validation data logs
    for i in ${LOGDIR}/compute_prob_valid.*; do
        trial=(${i//./ });
        trial=${trial[1]};
        grep -oP 'accuracy is [0-9]\.[0-9]+' $i | while read -r match; do
            myarray=($match);
            echo "valid" "'output-0'" "$trial" "${myarray[2]}" >> $OUTPUT;
        done
    done
    # loop over training data logs
    for i in ${LOGDIR}/compute_prob_train.*; do
        trial=(${i//./ });
        trial=${trial[1]};
        grep -oP 'accuracy is [0-9]\.[0-9]+' $i | while read -r match; do
            myarray=($match);
            echo "train" "'output-0'" "$trial" "${myarray[2]}" >> $OUTPUT;
        done
    done
elif [ $NNET == "nnet3" ]; then
    ## NNET3 ##
    # loop over validation data logs
    for i in ${LOGDIR}/compute_prob_valid.*; do
        trial=(${i//./ });
        trial=${trial[1]}    
        grep -oP '(?<=accuracy for).+(?= per frame)' $i | while read -r match; do
            myarray=($match);
            echo "valid" "${myarray[0]}" "$trial" "${myarray[2]}" >> $OUTPUT;
        done
    done
    # loop over training data logs
    for i in ${LOGDIR}/compute_prob_train.*; do
        trial=(${i//./ });
        trial=${trial[1]};
        grep -oP '(?<=accuracy for).+(?= per frame)' $i | while read -r match; do
            myarray=($match);
            echo "train" "${myarray[0]}" "$trial" "${myarray[2]}" >> $OUTPUT;
        done
    done
fi
