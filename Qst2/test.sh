#!/bin/bash
##run curl command to fetch metadata using Azure Instance Metadata Service##

curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2021-02-01" > metadata.json
echo "Instance Metadata"
cat metadata.json | jq
echo
echo "Do you want to see details of specific resource: Y/y/N/n"
echo
##take imput from user if they wants to see specific details"
read choice
if [ "$choice" != "y" ] && [ "$choice" != "Y" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ]; then
    echo "Invalid selection. Exiting"
    rm -f metadata.json
    exit 1
fi

while true; do
  if [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
      rm -f metadata.json
      exit 0
  else
      echo -e "\nAvailable Choices\n"
      ##extracts all the keys from the JSON data, including any array indices (numbers), and joins them together with dots (.) to form a path.##
      cat metadata.json | jq 'path(..) | select(length > 0) | map(tostring) | join(".")' > selection.txt
      cat selection.txt
      echo -e "\nSelect the choice and enter\n"

      read choice
      ## check if it's a valid choice. grep -q only returns the exit status , if the exit status is non-zero, script will execute the code block under if condition ##
      if ! grep -q "$choice" selection.txt; then
         echo "Invalid selection. Exiting"
         rm -f metadata.json selection.txt
         exit 1
      fi

      ##Required changes to the entered choice so that it can be used by jq as input arguments##
      choice=$(echo $choice | sed 's/"//g')
      choice=$(echo $choice | sed 's/.0/[0]/g')
      choice=".$choice"
      cat metadata.json | jq "$choice"

      echo -e "\nDo you want to check more: Y/y/N/n\n"
      read choice
      if [ "$choice" != "y" ] && [ "$choice" != "Y" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ]; then
         echo "Invalid selection. Exiting"
         rm -f selection.txt metadata.json
         exit 1
      fi

      if [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
         rm -f selection.txt metadata.json
         exit 0
      fi
  fi
done