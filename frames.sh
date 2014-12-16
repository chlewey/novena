FN="sh/$1.sh"
FNT="sh/${1%?}.sh"
FNS="sh/${1%??}.sh"

if [ -f $FN ]
then
	echo EXECUTING $FN
	bash $FN
elif [ -f $FNT ]
then
	echo EXECUTING $FNT
	bash $FNT ${1: -1}
elif [ -f $FNS ]
then
	echo EXECUTING $FNS
	bash $FNS ${1: -2}
else
	echo "Opción incorrecta '$1'." 1>&2
	echo $FN $FNT $FNS
	exit 1
fi

touch flags/$1
