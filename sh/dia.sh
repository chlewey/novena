case $1 in
1)
	TT=( 50 230 415 595 800 960 1150 )
	;;
2)
	TT=( 50 230 415 595 800 960 1150 )
	;;
3)
	TT=( 50 230 415 595 800 960 1150 )
	;;
4)
	TT=( 50 230 415 595 800 960 1150 )
	;;
5)
	TT=( 50 230 415 595 800 960 1150 )
	;;
6)
	TT=( 50 230 415 595 800 960 1150 )
	;;
7)
	TT=( 50 230 415 595 800 960 1150 )
	;;
8)
	TT=( 50 230 415 595 800 960 1150 )
	;;
9)
	TT=( 50 230 415 595 800 960 1150 )
	;;
*)
	echo 'Parámetro incorrecto "$1" en $0' 1>&2
	exit 1
	;;
esac

FNb="png/dia$1"
IFNb="svg/novena-dia$1"
VFNb="muted/dia$1"

for F in $IFNb*; do
	G=${F//svg/png}
	H=${G/novena-/}
	if [ ! -f $H ]; then
		inkscape -e $H -h 720 -w 1280 $F
	fi
done

I=0
S=0
X=
for T in ${TT[@]}; do
	FN=$FNb-$I.png
	VFN=$VFNb-$I.ts
	TS=$((T-S))
	tim=${TS:0: -1}.${TS: -1}
	echo $FNb-$I: $S--$T \($tim\)
	if [ ! -f $VFN ]; then
		avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -qscale 1 -t $tim -y $VFN
	fi
	X=$X\|$VFN
	S=$T
	I=$((I+1))
done
CAT=${X/\|/concat:}
echo $CAT

VFN="muted/dia$1.ts"
avconv -i $CAT -c:v copy -y $VFN
