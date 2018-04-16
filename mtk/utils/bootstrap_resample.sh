#!/bin/bash
# Joshua Meyer 2018

# USAGE:
#
#  ./bootstrap_resample.sh \
#         exp/libri-boot/nnet3/egs/egs.scp \
#         exp/libri-boot/nnet3/egs/egs.scp-boot \
#         .5

# input: egs.scp file output by prepare_multilingual_egs.sh (just get_egs.sh wrapper)
# output: scp file of same length, but resampled with replacement
#
#
#

infile=$1
outfile=$2
percentage=$3

num_egs=(`wc -l $infile`)
# this math will round down to nearest integer
float=( `echo "$percentage*$num_egs" | bc` )
integer=${float%.*}

shuf -n $integer $infile > $outfile

LC_ALL=C sort $outfile -o $outfile

