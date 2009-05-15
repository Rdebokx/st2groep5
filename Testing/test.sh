#!/bin/sh
A="A.txt"
X="X.txt"
Y="Y.txt"
OUTPUT="output.txt"

# Put the output in output.txt 
./6502 > output.txt

# ./6502 | sed -n '$LINE p' | awk '{print $2}'
# ./6502 | grep A-Register: | awk '{print $2 }'

# filter the values of the A-registers out of the output
$OUTPUT | grep A-Register | awk '{print $2}' > $A

file = $A 
index=0

while read line ; do
		ACCUMULATOR[$index]="$line"
			index=$(($index+1))
		done < $file

echo "A-reg is: ${ACCUMULATOR[*]}"


$OUTPUT | grep X-Register | awk '{print $2}' > $X
file = $X
index=0

while read line ; do
		REGX[$index]="$line"
			index=$(($index+1))
		done < $file

echo "A-reg is: ${REGX[*]}"

