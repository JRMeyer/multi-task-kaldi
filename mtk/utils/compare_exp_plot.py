# takes as input the output from extract-valid-ACC.sh script

# train 'output-1' 993 0.584804
# train 'output-0' 993 0.465945
# train 'output-1' 994 0.58572
# train 'output-0' 994 0.461604

import matplotlib.pyplot as plt
import numpy as np
import csv
from collections import defaultdict
from operator import itemgetter
import sys



###
### USAGE: compare_exp_plot.sh "atai_tri_tri libri-tri_tri_tri libri-half_tri_tri"
###

infiles=sys.argv[1].split(' ')
num_exps=len(infiles)

data = defaultdict(dict)

for infile in infiles:
    # example
    # infile: 100: .53

    
    with open(infile) as csvfile:
        reader = csv.reader(csvfile, delimiter=" ")
        
        for row in reader:
            if row[2] == "final":
                pass
            
            else:
                try:
                    data[infile]['0'].append( ( int(row[2]) , float(row[3])))
                except KeyError:
                    data[infile]['0'] = [ ( int(row[2]) , float(row[3]) ) ]


                



for i in range(num_exps):
        
    valid = [ [*x] for x in zip(* sorted(data[infiles[i]]['0'], key=itemgetter(0))) ]
    plt.plot(valid[0], valid[1], 'C'+str(2*i), label=infiles[i])

        
        


    
# if (int(args.numTasks) >= 2):
#     train1 = [ [*x] for x in zip(* sorted(data["train"]["'output-1'"], key=itemgetter(1))) ]
#     valid1 = [ [*x] for x in zip(* sorted(data["valid"]["'output-1'"], key=itemgetter(1))) ]
#     plt.plot(train1[0], train1[1], label='train-TASK-B')
#     plt.plot(valid1[0], valid1[1], label='valid-TASK-B')

    
# if (int(args.numTasks) >= 3):
#     train2 = [ [*x] for x in zip(* sorted(data["train"]["'output-2'"], key=itemgetter(1))) ]
#     valid2 = [ [*x] for x in zip(* sorted(data["valid"]["'output-2'"], key=itemgetter(1))) ]
#     plt.plot(train2[0], train2[1], label='train-TASK-C')
#     plt.plot(valid2[0], valid2[1], label='valid-TASK-C')

    
# if (int(args.numTasks) >= 4):
#     train2 = [ [*x] for x in zip(* sorted(data["train"]["'output-3'"], key=itemgetter(1))) ]
#     valid2 = [ [*x] for x in zip(* sorted(data["valid"]["'output-3'"], key=itemgetter(1))) ]
#     plt.plot(train2[0], train2[1], label='train-TASK-D')
#     plt.plot(valid2[0], valid2[1], label='valid-TASK-D')


    
plt.legend()
plt.xlabel('Training Iteration')
title=str('1-to-2 Target:Source Weighting // Kyrgyz + English MTL')

plt.title(title)
plt.ylabel('Frame Classification Accuracy')
plt.show()
