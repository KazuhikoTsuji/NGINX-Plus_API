#!/bin/sh

read -p "Which operation do you need?
	1. Getting current status.
	2. Adding node.
	3. Modifying weight.
	4. Disable node.
	5. Enable node.
        6. Deleting node.
Please enter number you are going to execute.: " OPERATION

if [ "$OPERATION" = "1" ];
then
  echo ---------
  echo Current status is below.
  sh ./staff/get_nodes.sh
  if [ $? = 0 ];
  then
    exit 0
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi


if [ "$OPERATION" = "2" ];
then
  sh ./staff/add_node.sh
  if [ $? = 0 ];
  then
    sh ./staff/success.sh
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi

if [ "$OPERATION" = "3" ];
then
  sh ./staff/modify_weight.sh
  if [ $? = 0 ];
  then
    sh ./staff/success.sh
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi

if [ "$OPERATION" = "4" ];
then
  sh ./staff/disable_node.sh
  if [ $? = 0 ];
  then
    sh ./staff/success.sh
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi

if [ "$OPERATION" = "5" ];
then
  sh ./staff/enable_node.sh
  if [ $? = 0 ];
  then
    sh ./staff/success.sh
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi

if [ "$OPERATION" = "6" ];
then
  sh ./staff/delete_node.sh
  if [ $? = 0 ];
  then
    sh ./staff/success.sh
  else
    sh ./staff/fail.sh
    exit 1
  fi
fi
