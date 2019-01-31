#!/bin/sh

clear
echo "Hi `/usr/bin/whoami`."
echo "This is operation console for Nginx-LB."

while true;
do
  sh ./staff/dialogue.sh
  read -p "Do you need to do any other operations? [y/n] " ANSWER
  if [ ! "$ANSWER" = "y" ];
  then
    echo "Good Bye!"
    break
  else
    clear
  fi  
done
