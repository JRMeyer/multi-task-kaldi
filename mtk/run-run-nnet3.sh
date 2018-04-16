#!/bin/bash


dim=50
num_epochs=1
main_dir=MTL








rm -rf /data/MTL/exp/nnet3
# rm -rf /data/MTL/exp/atai-org/nnet3
# rm -rf /data/MTL/exp/atai-foo/nnet3

./run_nnet3_multitask.sh "atai-org" "tri" "1.0" $dim $num_epochs $main_dir



exit
