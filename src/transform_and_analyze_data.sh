#/!/bin/bash
#I. Book The Adventures of Tom Sawyer
echo "I. Analyze the book 'The Adventures of Tom Sawyer'"

#1. Find out how many chapters in the book
echo -e "\t1. Chapters: $(grep "CHAPTER" data/the_Adventures_of_Tom_Sawyer.txt | wc -l | awk '{ print $1/2 }')"

#2. Count empty lines in the book
echo -e "\t2. Empty lines: $(grep -E '^(\s*$)' data/the_Adventures_of_Tom_Sawyer.txt | wc -l)"

#3. Count occurrences of Tom and  Huck
echo -e "\t3. 'Tom' occurrences: $(grep 'Tom' data/the_Adventures_of_Tom_Sawyer.txt | wc -w), 'Huck' occurrences: $(grep 'Huck' data/the_Adventures_of_Tom_Sawyer.txt | wc -w)"

#4. Count how often Huck and Tom appear together in the sam line
echo -e "\t4. Occurrences of 'Tom' and 'Huck' appears in the same line: $(grep -E 'Huck.*Tom|Tom.*Huck' data/the_Adventures_of_Tom_Sawyer.txt | wc -l)"

#5. Find the 3rd word in 1234th line
echo -e "\t5. 3rd word of the 1234th line: $(sed -n '1234p' data/the_Adventures_of_Tom_Sawyer.txt | awk '{ print $3 }')"

#6. Count total words and lines in the book
echo -e "\t6. Total lines: $(cat data/the_Adventures_of_Tom_Sawyer.txt | wc -l), total words: $(cat data/the_Adventures_of_Tom_Sawyer.txt | wc -w)"

#7. Translate every word into lowercase
cat data/the_Adventures_of_Tom_Sawyer.txt | tr \[:upper:] \[:lower:] > result/lower_the_Adventures_of_Tom_Sawyer.txt
echo -e "\t7. Translate every word from the book into lower case: result/lower_the_Adventures_of_Tom_Sawyer.txt"

#8. Count the occurrences of each word in the book The Adventures of Tom Sawyer
tr -c '[:alnum:]' '[\n*]' < result/lower_the_Adventures_of_Tom_Sawyer.txt | sort | uniq -c | sort -rn > result/word_count_Tom_Sawyer.txt
echo -e "\t8. Count the occcurrences of each word in the book: result/word_count_Tom_Sawyer.txt"

# 9. The word with the highest frequency
echo -e "\t9. The word with the highest frequency, with $(sed -n '2p' result/word_count_Tom_Sawyer.txt | awk '{ print $1 }') occurrences: $(sed -n '2p' result/word_count_Tom_Sawyer.txt | awk '{ print $2 }')"

# 10. Write step 7, 8, 9 in 1 statement
echo -e "\t10. The word with the highest frequency: $(cat data/the_Adventures_of_Tom_Sawyer.txt | tr \[:upper:] \[:lower:] | tr -c '[:alnum:]' '[\n*]' | sort | uniq -c | sort -rn | sed -n '2p' | awk '{ print $2 }')"

# 11. Get the 20 most frequent words of each book and get all the common words
echo -e "\t12. Words appear in top 20 most frequent word of both 2 books: $(comm -12 <(cat data/Moby_Dick.txt | tr \[:upper:] \[:lower:] | tr -c '[:alnum:]' '[\n*]' | sort | uniq -c | sort -rn | sed -n "2,21p" | awk '{ print $2 }'| sort) <( sed -n "2,21p" result/word_count_Tom_Sawyer.txt | awk '{ print $2 }'| sort) | tr '\n' ', ' | sed 's/,/, /g' | sed 's/, $/\./')"

echo -e "\n"

#II. Analyze the file city.csv
echo "II. Analyze the file 'city.csv'"

#1 & 2. Create a working copy file and exchange all occurences of Amazonas to Province of Amazonas
sed 's/\bPE,Amazonas\b/PE,Province of Amazonas/g' data/city.csv > result/copy_city.csv
echo -e "\t1&2. Create a copy file from city.csv and exchange all occurences of Amazonas to Province of Amazonas: result/copy_city.csv"

#3. Print all cities which have no population given
awk -F',' '$4 == "NULL" {print $3}' result/copy_city.csv | sed 's/"//g' > result/no_population_city.csv
echo -e "\t3. Print all cities which have no population given: result/no_population_city.csv"

#4. Print the line numbers of the cities in Great Britain (Code: GB)
awk -F',' '$2 == "GB" {print $3}' result/copy_city.csv | sed 's/"//g' | nl > result/Great_Britain_cities.csv
echo -e "\t4. Print the line number of the cities in Greate Britain: result/Great_Britain_cities.csv"

#5. Delete the records 5-12 and 31-34 from copy_city.csv and store the result in city.2.csv
sed "5,12d;31,34d" result/copy_city.csv > result/city_2.csv
echo -e "\t5. Delete the records 5-12 and 31-34 from city.csv: result/city.2.csv"

#6. Combine the used commands from the last two tasks and delete all british cities from the file copy_city.csv
awk -F',' '$2 != "GB" {print}' result/copy_city.csv > result/city_without_GB.csv
echo -e "\t6. Combine the used commands from the last two tasks and delete all british cities: result/city_without_GB.csv"
