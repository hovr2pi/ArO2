#!/bin/bash

export LD_LIBRARY_PATH=/opt/apps/intel/13/composer_xe_2013.2.146/mkl/lib/intel64:$LD_LIBRARY_PATH 
POINT=$1

cp geoms/geom.$POINT geom
cat geom > log.$POINT
cp  step1/* .

echo "invoking runc the first time on point $POINT"
runc -m 1000 >> log.$POINT
cp MOLDEN/molden_mo_mc.sp MOLDEN/molden_mo_mc.sp1
cp MOCOEFS/mocoef_mc.sp mocoef
cp  step2/* .
echo "invoking runc the second time on point $POINT"
runc -m 1000 >> log.$POINT
mkdir $POINT
cp -r LISTINGS $POINT
cp MOCOEFS/mocoef_mc.sp mocoef
cp -r MOCOEFS $POINT
cp -r MOLDEN $POINT
echo finishing geometry geom.$POINT
