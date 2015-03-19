
#     0   1   2   3   4   5   6   7   8   9  10  11  12
ta=( 2.5 5.0 5.5 5.0 4.5 5.0 4.5 5.0 5.0 5.0 6.0 5.0 2.5 )
tb=( 2.5 5.0 5.5 4.5 4.5 5.0 6.0 5.0 5.5 4.5 4.5 5.0 2.5 )

FNt="png/gozos-t.png"
IFNt="svg/novena-gozos-t.svg"
VFNt="muted/gozos-t.ts"
VFNr="muted/gozo-$1r.ts"

if [ ! -f $VFNt ]; then
	if [ ! -f $FNt ]; then
		if [ -f $IFNt ]; then
			inkscape -e $FNt -h 720 -w 1280 $IFNt
		else
			echo "Input file $IFNt not found." 1>&2
			exit 1
		fi
	fi
	avconv -loop 1 -i $FNt -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 2.5 -qscale 1 -y $VFNt
fi

if [ $1 -gt 0 ] && [ $1 -lt 12 ]; then

	FNa="png/gozo-$1a.png"
	IFNa="svg/novena-gozos-$1.svg"
	VFNa="muted/gozo-$1a.ts"

	if [ ! -f $FNa ]; then
		if [ -f $IFNa ]; then
			inkscape -e $FNa -h 720 -w 1280 $IFNa
		else
			echo "Input file $IFNa not found." 1>&2
			exit 1
		fi
	fi

	if [ ! -f $VFNa ]; then
		avconv -loop 1 -i $FNa -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t ${ta[$1]} -qscale 1 -y $VFNa
	fi

	FNb="png/gozo-$1b.png"
	IFNb="svg/novena-gozos-$1r.svg"
	VFNb="muted/gozo-$1b.ts"

	if [ ! -f $FNb ]; then
		if [ -f $IFNb ]; then
			inkscape -e $FNb -h 720 -w 1280 $IFNb
		else
			echo "Input file $IFNb not found." 1>&2
			exit 1
		fi
	fi

	if [ ! -f $VFNb ]; then
		avconv -loop 1 -i $FNb -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t ${tb[$1]} -qscale 1 -y $VFNb
	fi

	VFN="muted/gozo-$1.ts"

	#if [ ! -f $VFN ]; then
		avconv -i concat:$VFNa\|$VFNb -c:v h264 -y $VFN
	#fi
	
	ln -sf ${VFNt##*/} $VFNr
else
	FN="png/gozo-$1.png"
	IFN="svg/novena-gozos-$1.svg"
	VFN="muted/gozo-$1.ts"

	if [ ! -f $FN ]; then
		if [ -f $IFN ]; then
			inkscape -e $FN -h 720 -w 1280 $IFN
		else
			echo "Input file $IFN not found." 1>&2
			exit 1
		fi
	fi

	if [ ! -f $VFN ]; then
		avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t ${ta[$1]} -qscale 1 -y $VFN
	fi

	FNr="png/gozo-$1r.png"
	IFNr="svg/novena-gozos-$1r.svg"

	if [ ! -f $FNr ]; then
		if [ -f $IFNr ]; then
			inkscape -e $FNr -h 720 -w 1280 $IFNr
		else
			echo "Input file $IFNr not found." 1>&2
			exit 1
		fi
	fi

	if [ ! -f $VFNr ]; then
		avconv -loop 1 -i $FNr -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t ${tb[$1]} -qscale 1 -y $VFNr
	fi
fi


