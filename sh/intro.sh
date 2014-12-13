FN="png/intro$1.png"
IFN="svg/novena-intro-d$1.svg"
VFN="muted/intro$1.ts"

if [ ! -f $FN ]; then
	if [ -f $IFN ]; then
		inkscape -e $FN -h 720 -w 1280 $IFN
	else
		echo "Input file $IFN not found." 1>&2
		exit 1
	fi
fi

if [ ! -f $VFN ]; then
	avconv -loop 1 -i $FN -c:v h264 -tune stillimage -pix_fmt yuv420p -t 7 -qscale 1 -y $VFN
fi
