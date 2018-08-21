#!/bin/bash

dim=512
<<<<<<< HEAD
num_epochs=5
=======
num_epochs=2
>>>>>>> 3d353a04f35efe92ca6c09c2c6f5b36380818102
main_dir=MTL





<<<<<<< HEAD
# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100A-org" "tri" "1.0" $dim $num_epochs $main_dir
=======



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

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100B-org" "tri" "1.0" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100C-org" "tri" "1.0" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100D-org" "tri" "1.0" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100E-org" "tri" "1.0" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100F-org" "tri" "1.0" $dim $num_epochs $main_dir


# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100A-mod" "tri" "1.0" $dim $num_epochs $main_dir
>>>>>>> 3d353a04f35efe92ca6c09c2c6f5b36380818102

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100B-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100C-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100D-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100E-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100F-mod" "tri" "1.0" $dim $num_epochs $main_dir


<<<<<<< HEAD
# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100A-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100B-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100C-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100D-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100E-mod" "tri" "1.0" $dim $num_epochs $main_dir

# rm -rf MTL/exp/nnet3
# ./run_nnet3_multitask.sh "atai-100F-mod" "tri" "1.0" $dim $num_epochs $main_dir


rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100A-org atai-100A-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100B-org atai-100B-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100C-org atai-100C-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100D-org atai-100D-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100E-org atai-100E-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100F-org atai-100F-mod" "tri tri" "0.9,0.1" $dim $num_epochs $main_dir

mv ACC_* WER_* 5-epoch/512-dim/point-1/.


rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100A-org atai-100A-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100B-org atai-100B-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100C-org atai-100C-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100D-org atai-100D-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100E-org atai-100E-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100F-org atai-100F-mod" "tri tri" "0.7,0.3" $dim $num_epochs $main_dir

mv ACC_* WER_* 5-epoch/512-dim/point-3/.


rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100A-org atai-100A-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100B-org atai-100B-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100C-org atai-100C-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100D-org atai-100D-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100E-org atai-100E-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100F-org atai-100F-mod" "tri tri" "0.6,0.4" $dim $num_epochs $main_dir

mv ACC_* WER_* 5-epoch/512-dim/point-4/.



=======

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100A-org atai-100A-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100B-org atai-100B-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100C-org atai-100C-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100D-org atai-100D-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100E-org atai-100E-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir

rm -rf MTL/exp/nnet3
./run_nnet3_multitask.sh "atai-100F-org atai-100F-mod" "tri tri" "0.8,0.2" $dim $num_epochs $main_dir
>>>>>>> 3d353a04f35efe92ca6c09c2c6f5b36380818102

sudo shutdown now

<<<<<<< HEAD
=======
sudo shutdown now
>>>>>>> 3d353a04f35efe92ca6c09c2c6f5b36380818102
exit
