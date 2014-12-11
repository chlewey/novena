#!/bin/bash

FORCE=''
while getopts :f FLAG; do
	case $FLAG in
		f)
			FORCE=1
			;;
		:)
			echo -e \\n"Option -${BOLD}$OPTARG${NORM} requires an argument." >&2
			exit 1
			;;
	esac
done
shift $((OPTIND-1))

FRAMESI=(intro-d1 \
	todos-0 todos-1 todos-2 todos-3 todos-4 \
	gloria-i gloria-r gloria-i gloria-r gloria-i gloria-r)
FRAMES1=(dia1-0 dia1-1 dia1-2 dia1-3 dia1-4 dia1-5 dia1-6)
FRAMES2=(dia2-0 dia2-1 dia2-2 dia2-3 dia2-4 dia2-5 dia2-6 dia2-7)
FRAMES3=(dia3-0 dia3-1 dia3-2 dia3-3 dia3-4 dia3-5 dia3-6 dia3-7 dia3-8)
FRAMES4=(dia4-0 dia4-1 dia4-2 dia4-3 dia4-4 dia4-5 dia4-6 dia4-7)
FRAMES5=(dia5-0 dia5-1 dia5-2 dia5-3 dia5-4 dia5-5 dia5-6 dia5-7 dia5-8)
FRAMES6=(dia6-0 dia6-1 dia6-2 dia6-3 dia6-4 dia6-5 dia6-6)
FRAMES7=(dia7-0 dia7-1 dia7-2 dia7-3 dia7-4)
FRAMES8=(dia8-0 dia8-1 dia8-2 dia8-3 dia8-4 dia8-5 dia8-6)
FRAMES9=(dia9-0 dia9-1 dia9-2 dia9-3 dia9-4 dia9-5 dia9-6 dia9-7 dia9-8 dia9-9 dia9-10 dia9-10)
FRAMESJ=(maria-0 \
	ave-i ave-r ave-i ave-r ave-i ave-r ave-i ave-r ave-i \
	ave-r ave-i ave-r ave-i ave-r ave-i ave-r ave-i ave-r \
	jose-0 \
	padre-i padre-r ave-i ave-r gloria-i gloria-r \
	gozos-t gozos-0 gozos-0r \
	gozos-1 gozos-1r gozos-2 gozos-2r gozos-3 gozos-3r \
	gozos-4 gozos-4r gozos-5 gozos-5r gozos-6 gozos-6r \
	gozos-7 gozos-7r gozos-8 gozos-8r gozos-9 gozos-9r \
	gozos-10 gozos-10r gozos-11 gozos-11r gozos-12 gozos-12r \
	jesus-0 \
	cred-d1 patreon)

TIMESI=(0100 \
	0117 0218 0320 0435 0450 \
	0483 0520 0553 0590 1023 1060)
TIMES1=(0220 0410 0590 1190 1360 1550 2130)
TIMES2=(0010 0020 0030 0040 0050 0060 0070 0080)
TIMES3=(0010 0020 0030 0040 0050 0060 0070 0080 0090)
TIMES4=(0010 0020 0030 0040 0050 0060 0070 0080)
TIMES5=(0010 0020 0030 0040 0050 0060 0070 0080 0090)
TIMES6=(0010 0020 0030 0040 0050 0060 0070)
TIMES7=(0010 0020 0030 0040 0050)
TIMES8=(0010 0020 0030 0040 0050 0060 0070)
TIMES9=(0010 0020 0030 0040 0050 0060 0070 0080 0090 0100 0110 0120)
TIMESJ=(0270\
	0370 0420 0520 0570 1070 1120 1220 1270 1370 1420 1520 1570 2070 2120 2220 2270 2370 2420 \
	3040 \
	3130 3220 3320 3370 3403 3440 \
	3465 3500 3530 \
	4030 4060 4160 4190 4290 4320 \
	4420 4450 4550 4580 5080 5110 \
	5210 5240 5340 5370 5470 5500 \
	6000 6030 6130 6160 6260 6290 \
	7110 8000 8150)

echo ini: ${#FRAMESI[@]} ${#TIMESI[@]}

if [ -z "$1" ]; then
	echo Argument must be provided
	exit 1
fi

FRAMESI[0]=intro-d$1
FRAMESJ[$((${#FRAMESJ[@]}-2))]=credi-d$1

metaTIME=TIMES$1
metaFRAME=FRAMES$1
eval TIMESK=\( \${$metaTIME[@]} \)
eval FRAMESK=\( \${$metaFRAME[@]} \)
echo d $1: ${#FRAMESK[@]} ${#TIMESK[@]}

echo end: ${#FRAMESJ[@]} ${#TIMESJ[@]}

tt=0
AL=${#TIMESI[@]}
for i in $(seq 0 $((AL-1))); do
	NX=${TIMESI[$i]}
	NM=${NX:0:1}
	NS=${NX:1:2}
	NS=${NS#0}
	ND=${NX:3:1}
	FX=${FRAMESI[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON -h 720 -w 1280 $FN
		else
			echo -e \\n"WARNING: File ${BOLD}$FN${NORM} does not exist." >&2
		fi
	fi
	t0=$tt
	tt=$((ND+10*NS+600*NM))
	echo $FN from $((t+t0)) to $((t+tt)) \( $NM:$NS.$ND \)
	for j in $(seq $((t+t0+1)) $((t+tt))); do
		LN=`printf 'fr/v%d-%05d.png' $1 $j`
		ln -sf ../$ON $LN
	done
done
t=$((t+tt))

tt=0
AL=${#TIMESK[@]}
for i in $(seq 0 $((AL-1))); do
	NX=${TIMESK[$i]}
	NM=${NX:0:1}
	NS=${NX:1:2}
	NS=${NS#0}
	ND=${NX:3:1}
	FX=${FRAMESK[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON -h 720 -w 1280 $FN
		else
			echo -e \\n"WARNING: File ${BOLD}$FN${NORM} does not exist." >&2
		fi
	fi
	t0=$tt
	tt=$((ND+10*NS+600*NM))
	echo $FN from $((t+t0)) to $((t+tt)) \( $NM:$NS.$ND \)
	for j in $(seq $((t+t0+1)) $((t+tt))); do
		LN=`printf 'fr/v%d-%05d.png' $1 $j`
		ln -sf ../$ON $LN
	done
done
t=$((t+tt))

tt=0
AL=${#TIMESJ[@]}
for i in $(seq 0 $((AL-1))); do
	NX=${TIMESJ[$i]}
	NM=${NX:0:1}
	NS=${NX:1:2}
	NS=${NS#0}
	ND=${NX:3:1}
	FX=${FRAMESJ[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON -h 720 -w 1280 $FN
		else
			echo -e \\n"WARNING: File ${BOLD}$FN${NORM} does not exist." >&2
		fi
	fi
	t0=$tt
	tt=$((ND+10*NS+600*NM))
	echo $FN from $((t+t0)) to $((t+tt)) \( $NM:$NS.$ND \)
	for j in $(seq $((t+t0+1)) $((t+tt))); do
		LN=`printf 'fr/v%d-%05d.png' $1 $j`
		ln -sf ../$ON $LN
	done
done
t=$((t+tt))
