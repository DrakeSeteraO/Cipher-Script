#! /bin/bash
#
# cipher.sh is used to encypt and decrypt files in a modified ceasar cipher. 
# To do a basic encryption on a file you can run the command "./cipher.sh file.txt", where file.txt is the file you want to encrypt
#
#
# There are also 3 flags
#
# -e Signals to encrypt a file (enabled by default). An example would be "./cipher.sh -e file.txt"
#
# -d Signals to decrypt a file. An example would be "./cipher.sh -d file.txt"
#
# -n Signals the amount to shift over (default is 3). An example would be "./cipher.sh -n5 file.txt" -encrypts the file by 5
#
#
# Flags can also be combined except for -e and -d
#
# For example to encrypt a file by 5 you could run "./cipher.sh -en5 file.txt"
#
#Another example could be to decrypt the file by 5 "./cipher.sh -dn5 file.txt"
#
#
#Sources
#https://www.freecodecamp.org/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/ for arrays


encrypt () {
		wheel=('A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z')
		
		encryption=''
		for i in {0..61}
		do
				index=$(( ( $1 + $i) % 62))
				encryption="${encryption}${wheel[$index]}"
		done

		cat $2 | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz ${encryption} >temp.txt
		cat temp.txt > $2
		rm temp.txt
		echo "Success"
}


if [ -z $1 ]
then
		echo "Error: Missing File"
elif  [[ $1 == '-'* ]]
then
		if [[ $1 == *"n"* || $1 == *"d"* ||  $1 == *"e"* ]]
		then
				if [ -z $2 ]
				then
						echo "Error: Missing File"
				else
						amount=$(( 3 ))
						if [[ $1 == *"n"* ]]
						then
								amount=$( echo $1 | cut -d 'n' -f2 )
								amount=$(( amount ))
						fi


						if [[ $1 == *"d"* ]]
						then
								amount=$(( ( -1 * amount ) % 62 ))
								encrypt $amount $2
						else
								amount=$(( amount % 62 ))
								encrypt $amount $2
						fi
				fi
		else
				echo "Error: Missing Flag"
		fi
else
		encrypt 3 $1
fi
