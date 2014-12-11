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
	gloria-i gloria-r)
FRAMES1=(dia1-0 dia1-1 dia1-2 dia1-3 dia1-4 dia1-5 dia1-6)
FRAMES2=(dia2-0 dia2-1 dia2-2 dia2-3 dia2-4 dia2-5 dia2-6 dia2-7)
FRAMES3=(dia3-0 dia3-1 dia3-2 dia3-3 dia3-4 dia3-5 dia3-6 dia3-7 dia3-8)
FRAMES4=(dia4-0 dia4-1 dia4-2 dia4-3 dia4-4 dia4-5 dia4-6 dia4-7)
FRAMES5=(dia5-0 dia5-1 dia5-2 dia5-3 dia5-4 dia5-5 dia5-6 dia5-7 dia5-8)
FRAMES6=(dia6-0 dia6-1 dia6-2 dia6-3 dia6-4 dia6-5 dia6-6)
FRAMES7=(dia7-0 dia7-1 dia7-2 dia7-3 dia7-4 dia7-5 dia7-6)
FRAMES8=(dia8-0 dia8-1 dia8-2 dia8-3 dia8-4 dia8-5 dia8-6)
FRAMES9=(dia9-0 dia9-1 dia9-2 dia9-3 dia9-4 dia9-5 dia9-6)
FRAMESJ=(maria-0 \
	ave-i ave-r ave-i ave-r ave-i ave-r ave-i ave-r ave-i \
	ave-r ave-i ave-r ave-i ave-r ave-i ave-r ave-i ave-r \
	jose-0 \
	padre-i padre-r ave-i ave-r gloria-i gloria-r \
	gozos-0 gozos-1 gozos-2 gozos-3 gozos-4 gozos-5 gozos-6 \
	gozos-7 gozos-8 gozos-9 gozos-10 gozos-11 gozos-12 \
	jesus-0 \
	patreon)

TIMESI=(\
	0110 0130 0165 0345 0440 \
	1180 1380 2000)
TIMES1=(0010 0020 0030 0040 0050 0060 0070)
TIMES2=(0010 0020 0030 0040 0050 0060 0070 0080)
TIMES3=(0010 0020 0030 0040 0050 0060 0070 0080 0090)
TIMES4=(0010 0020 0030 0040 0050 0060 0070 0080)
TIMES5=(0010 0020 0030 0040 0050 0060 0070 0080 0090)
TIMES6=(0010 0020 0030 0040 0050 0060 0070)
TIMES7=(0010 0020 0030 0040 0050 0060 0070)
TIMES8=(0010 0020 0030 0040 0050 0060 0070)
TIMES9=(0010 0020 0030 0040 0050 0060 0070)
TIMESJ=(\
	1000 1040 1100 1140 1200 1240 1300 1340 1400 1440 1500 1540 2000 2040 2100 2140 2200 2240 \
	3000 \
	4000 4040 4100 4140 4200 4240 \
	5000 5100 5200 5300 5400 5500 6000 6100 6200 6300 6400 6500 7000 \
	8000 9000 9600)

echo ini: ${#FRAMESI[@]} ${#TIMESI[@]}

if [ -z "$1" ]; then
	echo Argument must be provided
	exit 1
fi

FRAMESI[0]=intro-d$1

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
	ND=${NX:3:1}
	FX=${FRAMESI[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON $FN
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
	NSa=${NX:1:1}
	NSb=${NX:2:1}
	NS=$((10*NSa+NSb))
	ND=${NX:3:1}
	FX=${FRAMESK[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON $FN
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
	ND=${NX:3:1}
	FX=${FRAMESJ[$i]}
	FN="svg/novena-"${FX}".svg"
	ON="png/novena-"${FX}".png"
	if [ ! -f $ON ] || [[ -n $FORCE ]]; then
		if [ -f $FN ]; then
			inkscape -e $ON $FN
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
