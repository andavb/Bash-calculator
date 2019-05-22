#!/bin/bash

#pravilen vnos mora biti tako da vpisemo stevila v matriko [ 1 2 3 4 , 5 6 7 8 ] vedno locimo s presledki
#./generirajMatriko.sh [ 1.23 2.45 3.4 5.3 , 1.3 1.4 2.72 4.56 ] [ 1 2 3 4 , 5 6 7 8 ]
#./generirajMatriko.sh [ 1.23 2.45 3.4 5.3 , 1.3 1.4 2.72 4.56 ] [ 12 32 43.2 -12.3 , 2 33.2 1.56 -12.452 ]
#./generirajMatriko.sh [ 1.23 2.45 3.4 , 1.3 1.4 2.72 ] [ 12 32 43.2 , 2 33.2 1.2 , 1 2 3 ]
#./generirajMatriko.sh [ 1 2 3 4 , 5 6 7 8 , 9 10 11 12 , 13 14 15 16 ] [ 1 1 -1 -2 , 5 -5 7 8 , -8 10 -11 12 , 13 14 -14 16 ]
#./generirajMatriko.sh [ 2 , 2 ] [ 2 2 ]
#vejica pomeni nova vrstica matrike.

stevec1=0
stevec2=0

if [ -f "matrika1.dat" ]
then
	rm "matrika1.dat"
fi

if [ -f "matrika2.dat" ]
then
	rm "matrika2.dat"
fi


if [ $1 != "[" ] #ce ne zacnemo vnasati pravilno
then
	echo "Napacen vnos!"
else

shift

	for var in "$@" #preberemo vse znake in ko pridemo do prvega ] vemo da smo prebrali celotno 1 matriko
	do
		if [ $var == "]" ]
		then
			shift
			break
		fi

	    if [ $var == "," ] #ce je vejica skoci v novo vrstico
	    then
	    	shift
	    	echo >> matrika1.dat 
	    	#doda novo vrstico
	    else
	    	printf "%0.2f" $var >> matrika1.dat
	    	stevec1=$[$stevec1+1]
	    	#zapise vrednost v datoteko
	    	printf "  " >> matrika1.dat
	    	#vrednosti locimo s presledki
	    	shift
	    fi
	done
	echo >> matrika1.dat

	stolpci1=$(head -n 1 matrika1.dat | wc -w)
	vrstice1=$(cat matrika1.dat | wc -l)

	skupaj=$(($stolpci1 * $vrstice1)) #dobimo koliko je vrednosti v matriki1

	if [ $skupaj -ne $stevec1 ] #st vrednosti v matriki1 se mora ujemati s stevcom, ki steje kolikokrat smo zapisali vrednost v mariko
	then
		echo "Vrtice in stolpci prve matrike se ne ujemajo!"
		rm matrika1.dat #zbirsemo datoteko in zakljucimo izvajanje
		exit 1
	fi

	stevec1=0
	stolpci1=0
	vrstice1=0

	shift

	for var in "$@" #preberemo vse znake in ko pridemo do prvega ] vemo da smo prebrali celotno 2 matriko
	do
		if [ $var == "]" ]
		then
			break
		fi
	    if [ $var == "," ]
	    then
	    	echo >> matrika2.dat
	    	#doda novo vrstico
	    elif [ $var == "]" ]
	   	then
	   		echo
	    elif [ $var != "]" ]
	    then
	    	printf "%0.2f" $var >> matrika2.dat
	    	stevec1=$[$stevec1+1]
	    	#zapise vrednost v datoteko
	    	printf "  " >> matrika2.dat
	    	#vrednosti locimo s presledki
	    fi
	done
	echo >> matrika2.dat


	stolpci1=$(head -n 1 matrika2.dat | wc -w)
	vrstice1=$(cat matrika2.dat | wc -l)

	skupaj=$(($stolpci1 * $vrstice1)) #dobimo koliko je vrednosti v matriki2

	if [ $skupaj -ne $stevec1 ]	#st vrednosti v matriki2 se mora ujemati s stevcom, ki steje kolikokrat smo zapisali vrednost v mariko
	then
		echo "Vrtice in stolpci druge matrike se ne ujemajo!"
		rm matrika1.dat
		rm matrika2.dat #zbirsemo obe datoteki in zakljucimo izvajanje
		exit 1
	fi
fi