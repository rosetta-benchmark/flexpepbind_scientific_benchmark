#!/bin/bash
for i in HDAC8 FTase GGTase
do
	cd $i
	head -5 score_analysis/I_sc >score_analysis/binder_I_sc
	tail -5 score_analysis/I_sc >score_analysis/nonbinder_I_sc
	
	for j in `cat score_analysis/binder_I_sc`;do
		for k in `cat score_analysis/nonbinder_I_sc`;do
			if [ 1 -eq `echo "${j} < ${j}" | bc` ]
			then  
    		echo "$i FAILED THE TEST"
				exit 1
			fi
		done
	done

	echo "$i PASSED THE TEST"
	rm score_analysis/binder_I_sc score_analysis/nonbinder_I_sc

cd ..
done

exit 0
