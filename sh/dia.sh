case $1 in
1)
	TT=( 22 41 59 79 96 115 133 )
	;;
2)
	TT=( 22 41 59 79 96 115 193 )
	;;
3)
	TT=( 22 41 59 79 96 115 193 )
	;;
4)
	TT=( 22 41 59 79 96 115 193 )
	;;
5)
	TT=( 22 41 59 79 96 115 193 )
	;;
6)
	TT=( 22 41 59 79 96 115 193 )
	;;
7)
	TT=( 22 41 59 79 96 115 193 )
	;;
8)
	TT=( 22 41 59 79 96 115 193 )
	;;
9)
	TT=( 22 41 59 79 96 115 193 )
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
	echo $FNb-$I: $S--$T \($((T-S))\)
	if [ ! -f $VFN ]; then
		avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 1 -qscale 1 -t $((T-S)) -y $VFN
	fi
	X=$X\|$VFN
	S=$T
	I=$((I+1))
done
CAT=${X/\|/concat:}
echo $CAT

VFN="muted/dia$1.ts"
avconv -i $CAT -c:v copy -y $VFN
