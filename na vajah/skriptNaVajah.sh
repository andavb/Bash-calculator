#!/usr/bin/env bash

# x = 1; NAPAKA

x=1
echo x
echo $x
y=$1
echo $y

unset y
#pobrisemo spremneljivko


ARRAY = (ONE TWO THREE)
echo ${ARRAY[*]}
#izpise one two three

echo ${ARRAY[2]}

#izpise three

unset ARRAY
#pobrisemo polje


vsota=1+2
echo "$vsota"


vsota=$((1+2))
echo $vsota


#floating points

echo $((1.11+2))
echo "(1.1111+2)" | bc -l

#ce zelimo racunati z natacnostjo 2 decimalk

echo "scale=2; (1.1111+2)/1" | bc -l

for i in 1 2 3 4 5 6 7 8 9 10; do
	echo $i
done

for i in(1..5); do
	$echo $i
done


for i in(0..10..2); do
	echo $i
done

for((c=1; c<=5; c++)); do
	echo $i
done

valm = 10

if [ $valm -lt 15 ]; then
	echo "$valm je mansje od 15"
else
	echo "$valm je vecje od 15"
fi  

read -p "Are you sure? " -n l -r

if [ $REPLY =una cudna sigma ^[Yy]$ ]]
then
	#nared neki
fi

primer(){
	echo "Izpis funkcije "
	echo $1
}


#sed in awk

#cat file | sed 's/iscemo/menjamo/g'
cat file | awk '{print $1}'
cat file | awk '{sum+=$1} END {print sum}'
cat file | awk '{sum+=$1} END {print "Povpr=',sum / NR}'

while [ $# -gt 0 ]
do
   if []; then
	shift
   fi
   shift
done

# najbrz najbl potreboval cat 1.txt | awk '{print $1}'

#za vajo ./kallukaltor.sh m1.txt m2.txt
 
