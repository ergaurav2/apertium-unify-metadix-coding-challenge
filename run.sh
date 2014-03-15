#!bin/bash
if [ $# !=  2 ]; then
	echo "Error: Invalid Number of Arguments!"
	echo "First argument should be <Path of the language dictionary file of .dix format>"
	echo "Second argument should be <Path of the output file with the file name>"
	echo "e.g. bash run.sh apertium-es-ca.es.dix output.txt"
	exit 1
fi
if [ ! -e $1 ];then
	echo "Input file $1 doesn't exits, please check"
	exit 1
fi
`xsltproc convert.xsl "$1" > "$2"`
