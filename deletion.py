import sys
import os

#Removes occurences of specific molecules from the files 

def search_string_in_file(file_name, string_to_search):
    """Search for the given string in file and return lines containing that string,
            along with line numbers"""
    line_number = 0

    string_to_search += " "


    # Open the file in read only mode
    with open(file_name, 'r') as read_obj:

        # Read all lines in the file one by one
        for line in read_obj:

            line_number += 1 

            if string_to_search in line:

                remove = "sed -i " + str(line_number) + 'd ' + file_name

                os.system(remove)

                line_number += -1

# Deleted from species and reaction files
search_string_in_file(sys.argv[1],sys.argv[3]) 
search_string_in_file(sys.argv[2],sys.argv[3])

#If you want to include grain reactions
search_string_in_file(sys.argv[4],sys.argv[3])
search_string_in_file(sys.argv[5],sys.argv[3])
