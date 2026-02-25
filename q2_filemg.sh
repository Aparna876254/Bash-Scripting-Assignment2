#!/bin/bash
while true
do
	echo "================================================"
	echo "         FILE AND DIRECTORY MANAGER             "
	echo "================================================"
	echo "1. List files in current directory "
	echo "2. create a new directory"
	echo "3. create a new file"
	echo "4. delete a file"
	echo "5. rename a file"
	echo "6. search for a file"
 	echo "7. count files and directories"
	echo "8. Exit"

	read -p "Enter you choice : " cha
	case $cha in
		1)
			ls -lh
			;;
		2)
			read -p "enter directory name :" dnm

			if [ -d "$dnm" ]; then
				echo "directory already exist! please select a different name"
			else
				mkdir "$dnm"
				echo "Directory created Successfully"
			fi
			;;
		3)
			read -p "enter file name:" fmm
			if [ -f "$fmm" ]; then
				echo "file already exists"
			else
				touch "$fmm"
				echo "file created successfully"
			fi
			;;
		4)
			read -p "enter file name to be deleted" dfnm
			if [ -f "$dfnm" ]; then
				read -p "are you sure you want to delete(y/n):" cnf
				if [ "$cnf" = "y" ]; then
					rm "$dfnm"
					echo "file deleted successfully"
				else
					echo "Deletion cancled"
				fi
			else
				echo "file with name: $dfnm does not exist!"
			fi
			;;
		5)
			read -p "enter old file name :" olda

			if [ -f "$olda" ]; then
				read -p "enter the new file name :" new
				mv "$olda" "$new"
				echo "File renamed successfully"
			else
				echo "file does not exist!"
			fi
			;;
		6)
			read -p "enter the file name pattern (eg : *.txt):" pat
			find . -name "$pat"
			;;
		7)
			fs=$(find . -type f | wc -l)
			drs=$(find . -type d | wc -l)

			echo "total files : $fs"
			echo "total directory : $drs"
			;;
		8)
			echo "Exiting"
			break
			;;
		*)
			echo "invalid choice!. Please make a correct choice"
			;;
	esac
done
