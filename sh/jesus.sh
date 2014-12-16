FN="png/jesus-0.png"
IFN="svg/novena-jesus-0.svg"
VFNi="muted/jesus.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNi ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 2 -t 42.5 -qscale 1 -y $VFNi
fi
