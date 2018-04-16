Multi-Task Kaldi
================

The collection of scripts in this repository represent a template for training neural networks via Multi-Task Learning in Kaldi. This repo is heavily based on the existing [Kaldi multilingual Babel example directory](https://github.com/kaldi-asr/kaldi/tree/master/egs/babel_multilang/s5).

`multi-task-kaldi` is an attempy to attain similar functionality to the multilingual Babel scripts, but have code which is more easily extendable. Adding a new language with `multi-task-kaldi` is as easy as creating a new `input_lang` dir. Running multiple tasks on the same corpus is not possible in the current multilingual Babel setup, but in `multi-task-kaldi` it is as easy as creating a new `input_task` dir. The code here aims to be easily readable and extensible, and makes few assumptions about the kind of data you have and where it's locatted on disk.

To get started, `multi-task-kaldi` should be cloned and moved into the `egs` dir of your local version of the [latest Kaldi branch](https://github.com/kaldi-asr/kaldi).






Creating the `input_task` dir
------------------------------------

The `input_task` dir is the only place you need to make adjustments for your new task (or new language). This directory contains information about the location of your data, lexicon, language model. 


Running the scripts
------------------------------------



The scripts will name files and directories dynamically. You will define the name of your input data (ie. task or language) in the initial `input_` dir, and then the rest of the generated dirs and files will be named accordingly. For instance, if you have `input_your-task`, then the GMM alignment stage will create `data_your-task`, `plp_your-task` and `exp_your-task`.




### Force Align Training Data (GMM)

`$ ./run_gmm.sh your-task test001`

- `your-task` should correspond exactly to `input_your-task`. In multilingual training, this will be `input_lang1`, `input_lang2`, etc. In monolingual Multi-Task Learning, this will be `input_task1`, `input_task2`, etc.

- `test001` is any character string, and is written to the name of the WER file: `WER_nnet3_your-corpus_test001.txt`


### Format data from GMM $-->$ DNN

`$ ./utils/setup_multitask.sh to_dir from_dir "your-task1 your-task2 your-task3"`

- all `nnet3` log files and experimental data will be written to `to_dir`

- the output dirs from GMM alignment should exist at `from_dir`

- the task names `"your-task1 your-task2 your-task3"` must correspond to input dir names as such: `input_your-task1`, `input_your-task2`, etc. However, do not include the initial `input_` here.



### Multi-Task Learning (DNN)

`$ ./run_nnet3_multitask.sh `

