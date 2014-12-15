FN="png/padre-i.png"
IFN="svg/novena-padre-i.svg"
VFNi="muted/padre-i.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNi ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 10.0 -qscale 1 -y $VFNi
fi

FN="png/padre-r.png"
IFN="svg/novena-padre-r.svg"
VFNr="muted/padre-r.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNr ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 8.5 -qscale 1 -y $VFNr
fi

VFN="muted/padre.ts"

avconv -i concat:$VFNi\|$VFNr -c:v copy -y $VFN
