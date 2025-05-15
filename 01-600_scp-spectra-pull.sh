#!/bin/bash
# This script copies nmr files from nmr950 to the current directory at the local computer and calculates values to be used for referencing.
# Run it with source command
echo "First Expno:"
read FE
echo "Last Expno:"
read LE
B=$FE
for((I=$((FE + 1));$I <= $LE;I++)); do
	B="$B,$I"
#	echo $B
done
echo $B
scp -r nmr600:/d1/data/PSD/nmr/MAP2c/\{$B\} ./

cd ./$FE
cp /scratch/plucarova/dir_spectraMAP2c/dir_scripts/ft2.com ./
cp /scratch/plucarova/dir_spectraMAP2c/dir_scripts/ft2.sh ./ #copies scripts needed for procesing
cp /scratch/plucarova/dir_spectraMAP2c/dir_scripts/old-fid.com ./
module add nmrpipe
module add sparky
ls	# The following part within '' calculates carrier frequences from acqus file
awk '/BF1/ {BF1 = $2
	}
/BF2/ {BF2 = $2
	}
/BF3/ {BF3 = $2
	}
/O1=/ && !/F/ {O1 = $2
	}
/O2=/ && !/F/ {O2 = $2
	}
/O3=/ && !/F/ {O3 = $2
	}
END { print BF1, BF2, BF3, O1, O2, O3;
	H = O1 / BF1;
	C = O2 / BF2;
	N = O3 / BF3;
	temp = 300.2;
	pH = 6.9;
	SC = 100;
	printf("BF1%11.4f\nO1 %11.4f\nT  %11.4f\npH %11.4f\nSC %11.4f\n1H %11.4f\n13C%11.4f\n15N%11.4f\n",BF1,O1,temp,pH,SC,H,C,N);
#	print BF1,O1,temp,pH,SC,H,C,N;
}
' acqus
bruker & #create fid.com
gvim acqus &  #to check the frequency values if needed
~plucarova/bin/xcar2 # use the values from the standard output
