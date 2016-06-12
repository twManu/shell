#!/bin/sh
#
# Taken scan.LOG as output of A180 debug message and format the stitistics
# in file tmp.log
#

# there are 37 channels in area of post code 95035
#
LOG_FILE=scan.LOG
TMP_FILE=tmp.log
STATISTIC_FILE=statistic.log

# extract critical information
#
cat $LOG_FILE | awk '/:ATSCTunerNodeGetSignalLocked|:ATSCTunerNodeGetSignalStrength|:ATSCTunerNodeGetSignalQuality|:SetATSCFrequency/ {print}' > $TMP_FILE


# format as
#	 freq (lock,strength,quality)
#    for each iteration
cat $TMP_FILE | \
awk 'NR%4 == 1 { freq=$5 }; NR%4 == 2 { lock=$5 }; NR%4 == 3 { strength=$5 }; NR%4 == 0 \
{print freq, "("lock","strength","$5")"}' > $STATISTIC_FILE


# format as
#	 freq (lock,strength,quality) (lock,strength,quality)...
#    for each distict frequency
FREQ_LIST=
cur_freq=
line=1

for i in `cat $STATISTIC_FILE`; do
	if [ 1 == `expr $line % 2` ]; then	# frequency
		if [ ! "0${FREQ_COUNTs["$i"]}" -gt 0 ]; then
			# remember each distinct frequency
			FREQ_LIST="$FREQ_LIST $i"
			FINAL_LISTs["$i"]=$i
			let FREQ_COUNTs["$i"]++
		fi
		cur_freq=$i
	else					# (lock,strength,quality)
		FINAL_LISTs["cur_freq"]="${FINAL_LISTs["cur_freq"]} $i"
	fi
	let line++
done


# print result

echo '============ statistics =======================================' >>$TMP_FILE
echo 'frequency (lock, strength, quality) (lock, strength, quality...' >>$TMP_FILE
echo '===============================================================' >>$TMP_FILE
for i in $FREQ_LIST; do
	echo ${FINAL_LISTs["$i"]} >> $TMP_FILE
done
