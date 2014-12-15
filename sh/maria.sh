FN="png/maria-0.png"
IFN="svg/novena-maria-0.svg"
VFNi="muted/maria.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFNi ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -r 1 -t 28 -qscale 1 -y $VFNi
fi
