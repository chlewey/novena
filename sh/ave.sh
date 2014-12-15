FN="png/ave-i.png"
IFN="svg/novena-ave-i.svg"
VFNi="muted/ave-i.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNi ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 10.5 -qscale 1 -y $VFNi
fi

FN="png/ave-r.png"
IFN="svg/novena-ave-r.svg"
VFNr="muted/ave-r.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNr ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 5.5 -qscale 1 -y $VFNr
fi

VFN="muted/ave.ts"

avconv -i concat:$VFNi\|$VFNr -c:v copy -y $VFN
