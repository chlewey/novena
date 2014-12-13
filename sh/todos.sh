
IFA=( todos-0 todos-1 todos-2 todos-3 todos-4 )
IFN=( 4 23 44 67 70 )
K=0
M=${#IFA[@]}
echo FRAMES: $M
for I in $(seq 0 $((M-1))); do
	F=${IFA[$I]}
	N=${IFN[$I]}
	echo $F $K $N
	FN="png/$F.png"
	IFN="svg/novena-$F.svg"
	if [ ! -f $FN ]; then
		if [ -f $IFN ]; then
			inkscape -e $FN -h 720 -w 1280 $IFN
		else
			echo "Input file $IFN not found." 1>&2
			exit 1
		fi
	fi
	for J in $(seq $((K+1)) $N); do
		echo MAKING $I: $J
		ln -sf ../$FN `printf 'fr/todos-%03d.png' $J`
	done
	K=$N
	echo $K $N
done

avconv -r 2 -i fr/todos-%03d.png -t 35 -c:v h264 -qscale 1 -y muted/todos.ts
