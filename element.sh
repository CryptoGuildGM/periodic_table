#!/bin/bash

#A simple Bash/SQL project from freecodecamp to retrieve data about atomic elements from a postgres database.

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[  -z $1  ]]
then
  echo "Please provide an element as an argument."
  exit
fi

#if atomic number 
re='^[0-9]+$'
if [[  $1 =~ $re ]]
then
  FIND_ELEMENT_BY_NUMBER_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")

  #if no element found
  if [[  -z $FIND_ELEMENT_BY_NUMBER_RESULT  ]]
  then
    echo "I could not find that element in the database."
    exit
  fi

  #output the result
  echo $FIND_ELEMENT_BY_NUMBER_RESULT | while IFS=" |" read TYPE_ID NUMBER SYMBOL NAME MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done 
  exit  
fi

#if atomic symbol
re2='[A-Z]\w?$'
if [[  $1 =~ $re2 ]]
then
  FIND_ELEMENT_BY_SYMBOL_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1'")

  #if no element found
  if [[  -z $FIND_ELEMENT_BY_SYMBOL_RESULT  ]]
  then
    echo "I could not find that element in the database."
    exit
  fi

  #output the result
  echo $FIND_ELEMENT_BY_SYMBOL_RESULT | while IFS=" |" read TYPE_ID NUMBER SYMBOL NAME MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  exit   
fi

#if name
re3='^[A-Z]*'
if [[  $1 =~ $re3 ]]
then
  FIND_ELEMENT_BY_NAME_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1'")
  #if no element found
  if [[  -z $FIND_ELEMENT_BY_NAME_RESULT  ]]
  then
    echo "I could not find that element in the database."
    exit
  fi

  #output the result
  echo $FIND_ELEMENT_BY_NAME_RESULT | while IFS=" |" read TYPE_ID NUMBER SYMBOL NAME MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done 
fi
