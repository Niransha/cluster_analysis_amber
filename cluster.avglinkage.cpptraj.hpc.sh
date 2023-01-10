#!/bin/bash
# CPPTRAJ average linkage method #

#SBATCH -J clust
##SBATCH -N 1
#SBATCH -n 1
#SBATCH -p longq7-rna
##SBATCH --mail-type=ALL
##SBATCH --nodelist=nodeamd002
#SBATCH --mem=70G
#SBATCH --exclusive
##SBATCH --exclude=nodegpu[021-025]

###################################
#load amber 18 on atlas
###################################
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/amber.sh
source /opt/ohpc/pub/apps/rnachem/amber18_gpu/modules2load.txt


cat>input<<EOF
parm ./strip.prmtop.new
trajin ./combined_md.mdcrd

cluster averagelinkage epsilon 1.2 sieve 5 random \
rms first :1-4&!@H= \
singlerepout traj singlerepfmt netdcf \
clusterout clust_traj clusterfmt netcdf \
repout rep repfmt pdb \
avgout avg avgfmt pdb \
info info.dat
go
EOF

cpptraj -i input


