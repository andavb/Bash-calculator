#!/bin/bash

function add(){ #funkcija za sestevanje
	stevec=0
	rezultat=()
	if [ $vrstice1 != $vrstice2 ] || [ $stolpci1 != $stolpci2 ] #Stevilo stolpcev in vrstic mora biti pri obej matrikah enako
	then
		echo "Za sestevanje morata biti matrike ISTE velikosti!"
		exit 1
	else
		for(( x=0; x<$vrstice1; x++ )) #sprehodimo se cez vrstice
		do
			echo
			for(( y=0; y<$stolpci1; y++ )) #sprehodimo se cez stolpce
			do
				rezultat[$stevec]=`echo ${polje1[$stevec]} + ${polje2[$stevec]} | bc` #zapisemo rezultat v novo polje
				size=${#rezultat[$stevec]}
				printf "%0.2f" ${rezultat[$stevec]} #izpisemo rezultat na 2 decimalni mesti natancno

				for (( i = $size; i < 10; i++ )) #for zanka za lepsi zapis 
				do
					printf " "
				done

  				stevec=$[$stevec+1]
			done
		done
		echo
	fi
	unset rezultat
}


function subtract(){ #funkcija za odstevanje
	stevec=0
	rezultat=()
	if [ $vrstice1 != $vrstice2 ] || [ $stolpci1 != $stolpci2 ] #Stevilo stolpcev in vrstic mora biti pri obej matrikah enako
	then
		echo "Za sestevanje morata biti matrike ISTE velikosti!"
		exit 1
	else
		for(( x=0; x<$vrstice1; x++ ))  #sprehodimo se cez vrstice
		do
			echo
			for(( y=0; y<$stolpci1; y++ )) #sprehodimo se cez stolpce
			do
				rezultat[$stevec]=`echo ${polje1[$stevec]} - ${polje2[$stevec]} | bc`  #zapisemo rezultat v novo polje
				size=${#rezultat[$stevec]} #rabimo pri ureditvi izpisa
				printf "%0.2f" ${rezultat[$stevec]} #izpisemo rezultat na 2 decimalni mesti natancno
				#echo $size
				for (( i = $size; i < 10; i++ )) #for zanka za lepsi zapis 
				do
					printf " "
				done

  				stevec=$[$stevec+1]
			done
		done
		echo
	fi
	unset rezultat
}

function multiply(){ #funkcija za mnozenje
	stevec=0
	if [ $stolpci1 != $vrstice2 ] #Za mnozenje mora imeti prva toliko stolpcev kot ima druga vrstic!
	then
		echo "Za mnozenje mora imeti prva toliko stolpcev kot ima druga vrstic!"
		exit 1
	else
		for(( x=0; x<$(($vrstice1 * $stolpci1)); x+=stolpci1 )) #ker bash nima vecdimenzionalnih polj prilagodimo for zanke tako da gre prva vrtice*stolpci prve matrike
		do
			for(( y=0; y<$stolpci2; y++ )) #sprehodimo se cez stolpec druge matrike
			do
				for (( i = 0, t=0; i < $stolpci1; i++, t+=$vrstice2 )) #i se sprehodi cez stolpce prve matrike, t pa se povecuje za toliko kot je vrtic v 2 matriki saj potrebujemo naslednjo spodnjo vrednost druge matrike pri mnozenju
				do
					rezultat[$stevec]=$(awk -v prva="${polje1[$(($x + $i))]}" -v druga="${polje2[$(($t + $y))]}" -v rez="${rezultat[$stevec]}" 'BEGIN{print (rez+(prva*druga))}')
					#rezultat zapisemo z ukazom awk, naredimo mnozenje polja1[x+i]*polje2[t+y] + trenutna vrednost rezultata
				done
				stevec=$[$stevec+1]
			done
		done
		echo


		st=$((${#rezultat[@]} / $vrstice1 - 1)) #potrebujem za lepsi izpisu, da algoritem ve kdaj mora iti v novo vrsrtico pri izpisu
		pomozni=0

		for (( i = 0; i < $(($vrstice1 * $stolpci2)); i++ )) #sprehodimo se cez dobljene rezultate v polju rezultat[]
		do

			size=${#rezultat[$i]}
			printf "%0.2f" ${rezultat[$i]} #izpisemo na 2 decimalni natancno

			for (( j = $size; j < 10; j++ )) #za lepsi izpis dodajamo presledke
			do
				if [ $size > 3 ]
				then
					printf " "
				else
					printf ""
				fi
			done

			if [ $pomozni == $st ] #pogoj za novo vrstico
			then
				echo
				pomozni=-1
			fi
			pomozni=$(($pomozni + 1))
		done
	fi
	unset rezultat
}


polje1=()
polje2=()
stevec=0

exec 5<$1
exec 6<$2

stolpci1=$(head -n 1 $1 | wc -w) #dobimo stolpce in vrstice obeh matrik
vrstice1=$(cat $1 | wc -l)

stolpci2=$(head -n 1 $2 | wc -w)
vrstice2=$(cat $2 | wc -l)

#echo "stolpci1: "${stolpci1} #izpis
#echo "vrstice1: "${vrstice1}

#echo "stolpci2: "${stolpci2}
#echo "vrstice2: "${vrstice2}


for (( l=0; l<$vrstice1; l++ )) #beremo iz datoteke in zapisujemo v polje1 matriko1
do
read -a arr -u 5
  for (( c=0; c<$stolpci1; c++ ))
  do
  polje1[$stevec]=${arr[$c]}
  stevec=$[$stevec+1]
  done
done

stevec=0

for (( l=0; l<$vrstice2; l++ )) #beremo iz datoteke in zapisujemo v polje2 matriko2
do
read -a arr -u 6
  for (( c=0; c<$stolpci2; c++ ))
  do
  polje2[$stevec]=${arr[$c]}
  stevec=$[$stevec+1]
  done
done


if [ $3 == "add" ] #ali je 3 parameter add
then
	add #poklicemo funkcijo add
elif [ $3 == "subtract" ] #ali je 3 parameter subtract
then
	subtract #poklicemo funkcijo subtract 
elif [ $3 == "multiply" ] #ali je 3 parameter multiply
then
	multiply  #poklicemo funkcijo multiply 
fi

unset polje1 #pobrisemo iz polj
unset polje2