#!/bin/bash

#This script determines dependent molecules to a set of "core" molecules using the nautilus simulation

#Reads in the list of species in the simulation

> essential.txt
> notfound.txt
> values.txt
while IFS= read -r line
do
	#Prints the molecule being removed
	echo $line

	#Moves out original files
	cp gas_species.in gas_species_old.in

	cp gas_reactions.in gas_reactions_old.in
	
	cp grain_species.in grain_species_old.in

	cp grain_reactions.in grain_reactions_old.in
	#Deletes instances of the molecule from the files
	python3 deletion.py gas_species.in gas_reactions.in $line grain_species.in grain_reactions.in
	
	#Runs the simulation
	echo "simulating..."
        /home/vivekv/nautilus-1.1/nautilus-1.1/nautilus

        #nautilus_code
        #nautilus_outputs

        /home/vivekv/nautilus-1.1/nautilus-1.1/nautilus_outputs	
	
	#If the simulation was successful
	if [[ -d "ab" ]]
	then	
		echo "ab found..."
		
		#Read in a molecule from the selected "core" list
		while IFS= read -r molecule
	        do	
			#Stored file molecation relative to simulatin directory
			#The funny characters are only neccessary for windows systems (^M CR characters)
			file=ab/${molecule%$'\r'}.ab	
	
			echo $file
			
			#If the files are found (basically to ignore the "core" list)
			if [ -f "$file" ]
			then	
				#Determines if the molecule is essential, stores it in a file called essential.txt
				echo "calculating..."
				python3 difference.py /home/vivekv/nautilus-1.1/nautilus-1.1/testing/${file} /home/vivekv/nautilus-1.1/nautilus-1.1/batman/${file} 10 $line
				echo "calculation complete"
			#If the molecule is not found stored in in file (Pretty much the core compounds
			else
				echo "not found"
				
				echo ${molecule%$'\r'} >> notfound.txt	

				#This was used to clean up for debugging

				#../scripts/nautilus-clean.sh

				#mv gas_reactions_old.in gas_reactions.in

				#mv gas_species_old.in gas_species.in

				#rm essential.txt
				#touch essential.txt

				#exit 0
			fi

			
			
	        done < test_species.in #"core" list

	#If simulation failed, molecule is assumed essential to model
	else
		echo "no ab...essential"
		echo $line >> essential.txt
	fi

	#Resets 
	#../scripts/nautilus-clean.sh
	
	mv gas_reactions_old.in gas_reactions.in

	mv gas_species_old.in gas_species.in
	
	mv grain_species_old.in grain_species.in

	mv grain_reactions_old.in grain_reactions.in
	echo "cleaned"
echo $line	
exit 0
done < gas_species_source.in #List of molecules in the simulation


#sort essential2.txt | uniq >> core_sorted2.txt #Removed duplicates

#sort notfound2.txt | uniq >> notfound_sorted2.txt

cat essential.txt test_species.in > core_sorted.txt

sort core_sorted.txt | uniq > core_sorted_total.txt


