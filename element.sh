#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENT=$1

if [[ -z $ELEMENT ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $ELEMENT =~ ^[0-9]+$ ]]
    then
      get_DATA=$($PSQL "Select atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) Where atomic_number = '$ELEMENT'")
      if [[ -z $get_DATA ]]
      then
          echo "I could not find that element in the database."
      else
        echo $get_DATA | while IFS="|" read NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELT BOIL
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
  else [[ $ELEMENT =~ ^[a-z]+$ ]]
      get_DATA=$($PSQL "Select atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) Where symbol = '$ELEMENT' or name = '$ELEMENT'")
      if [[ -z $get_DATA ]]
      then
        echo "I could not find that element in the database."
      else
        echo $get_DATA | while IFS="|" read NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELT BOIL
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
  fi  
fi
