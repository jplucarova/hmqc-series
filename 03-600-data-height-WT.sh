#!/bin/bash
# This script extracts the intensities (heights) of selected peaks from the list files, aligns them with corresponding time stamps
# and saves the results in a file that can be plotted with gnuplot
#SPACE='            '
SPACE2='           '
SPACE3='  '
#echo "# $SPACE3 pY67E $SPACE YE $SPACE 002 $SPACE 003" >WT-pl-peak-intensities.txt

echo "# $SPACE3 pY67E" > WT-pl-pY67.txt
echo "$SPACE2 YE" > WT-pl-YE.txt
echo "$SPACE2 2" > WT-pl-2.txt
echo "$SPACE2 3" > WT-pl-3.txt

for i in `ls *.list | sort -n`; do
	#	echo $i
	awk -v s=$i '$1 ~ /^pY67$/ {print substr(s,1,4),$4};' $i
done >> WT-pl-pY67.txt

for i in `ls *.list | sort -n`; do
	#	echo $i
	awk -v s=$i '$1 ~ /^YE$/ {print $4};' $i
done >> WT-pl-YE.txt

for i in `ls *.list | sort -n`; do
	#echo $i
	awk -v s=$i '$1 ~ /^002$/ {print $4};' $i
done >> WT-pl-2.txt

for i in `ls *.list | sort -n`;; do
	#	echo $i
	awk -v s=$i '$1 ~ /^003$/ {print $4};' $i
done >> WT-pl-3.txt

#for i in `ls *.list | sort -n`; do
#	echo $i
#awk -v s=$i '$1 ~ /^004$/ {print $4};' $i
#done > 4.txt

paste WT-pl-pY67.txt WT-pl-YE.txt WT-pl-2.txt WT-pl-3.txt > WT-pl-peak-intensities.txt
paste WT-pl-time-H.dat WT-pl-peak-intensities.txt > WT-for-RII-time-peak-intensities.txt
