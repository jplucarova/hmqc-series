#!/bin/bash
# This script extracts the start time of the first experiment in the series and completion time of each of the experiments from the audita files
# and calculates the time from the start of the first experiment to the end of each of the experiments in series.
# The script is run in the directory where the audita files are located.
# The result is saved in the file WT-pl-time-H.dat


SPACE='   '
SPACE2='           '
SPACE3='  '
#SPACE4=' '
echo "# $SPACE3 h m $SPACE s $SPACE m+s $SPACE Time [h] " > WT-pl-time-H.dat


a=0
for i in `ls */audita.txt`
do
	(( a = a + 1 ))

	if [[ $a -eq 1 ]]; then
		awk -v s=$i '$1 ~ /^started/ {print substr(s,1,4),$4};' $i
	fi
		awk -v s=$i '$1 ~ /^completed/ {print substr(s,1,4),$4};' $i

#^ - beginnig of field $ - end of field
done > expno-time.dat
sed -i "" 's/:/ : /g' expno-time.dat

# The following part within '' calculates the time from the start of the first experiment in hours
awk '
BEGIN {
    idx = 0;
}

{
    S[idx] = $6;
    M[idx] = $4;
    H[idx] = $2;
    E[idx] = $1;
    idx++;
    T = 0
}

END {
    for(i=1; i<idx; i++){
        DH = H[i] - H[i-1];
        if(DH < 0){
            DH = 24 + DH;
        };
        DM = M[i] - M[i-1];
        if(DM < 0){
            DM = 60 + DM; DH = DH - 1
        };
        DS = S[i] - S[i-1];
        if(DS < 0){
            DS = 60 + DS; DM = DM - 1
        };

        MH = DM / 60;
        SH = DS / 3600;
        Htot = MH + SH + DH;
        T = T + Htot;

    #    MS = 60 * DM;
    #    Tot = MS + DS;
    #    T = T + Tot;
    #    H = T / 3600

        print E[i],DH,DM,DS,Htot,T;
    }
}' expno-time.dat >> WT-pl-time-H.dat

