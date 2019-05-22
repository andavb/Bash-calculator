#!/bin/bash

generirajMatriko="./generirajMatriko.sh"
kaluklator="./kalkulator.sh"
matrika1="matrika1.dat"
matrika2="matrika2.dat"
add="add"
subtract="subtract"
multiply="multiply"
prva="[ 1.23 2.45 3.4 5.3 , 1.3 1.4 2.72 4.56 ] [ 1 2 3 4 , 5 6 7 8 ]"
druga="[ 2 , 2 ] [ 2 2 ]" #  [2 2
						  #   2 2]
tretja="[ 11 1 13.2 24 , 5.3 6 7 8 , 9 10 11 12 , 13 14 15 16 ] [ 1 1 -1 -2 , -5 -5 7 8 , -8.23 4 -11.222 12 , 3 4.123 -4 6.34 ]"

$generirajMatriko $prva

if [ -f "matrika1.dat" ]
then
	if [ -f "matrika2.dat" ]
	then
		echo
		echo "podana matrika: " $prva
		echo "Sestevanje"
		sh $kaluklator $matrika1 $matrika2 $add
		echo

		echo "Odstevanje"
		sh $kaluklator $matrika1 $matrika2 $subtract
		echo

		echo "Mnozenje"
		sh $kaluklator $matrika1 $matrika2 $multiply
		echo

		$generirajMatriko $druga

		echo "podana matrika: " $druga

		echo "Sestevanje"
		sh $kaluklator $matrika1 $matrika2 $add
		echo

		echo "Odstevanje"
		sh $kaluklator $matrika1 $matrika2 $subtract
		echo

		echo "Mnozenje"
		sh $kaluklator $matrika1 $matrika2 $multiply
		echo

		$generirajMatriko $tretja

		echo "podana matrika: " $tretja
		
		echo "Sestevanje"
		sh $kaluklator $matrika1 $matrika2 $add
		echo

		echo "Odstevanje"
		sh $kaluklator $matrika1 $matrika2 $subtract
		echo

		echo "Mnozenje"
		sh $kaluklator $matrika1 $matrika2 $multiply
		echo


	else
		echo "Matrika2 se ni ustvarila, preverite premissions.."
		exit 1
	fi
else
	echo "Matrika1 se ni ustvarila, preverite premissions.."
	exit 1
fi

if [ -f "3" ]
then
	rm 3
fi

if [ -f "matrika1.dat" ]
then
	rm $matrika1
	if [ -f "matrika2.dat" ]
	then
		rm $matrika2
	fi
fi

