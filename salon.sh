#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  # get all services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES" | while IFS="|" read SERVICE_ID NAME 
  do
    SERVICE_ID_TRIMMED=$(echo $SERVICE_ID | sed 's/ //g')
    NAME_TRIMMED=$(echo $NAME | sed -E 's/^ *| *$//g')
    echo "$SERVICE_ID_TRIMMED) $NAME_TRIMMED"
  done
  read SERVICE_ID_SELECTED
  SERVICE_ID_SELECTED=$(echo $SERVICE_ID_SELECTED | sed 's/ //g')
  SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED");
  SERVICE_NAME_SELECTED=$(echo $SERVICE_NAME_SELECTED | sed -E 's/^ *| *$//g')
  if [[ -z $SERVICE_NAME_SELECTED ]]
  then
  echo -e "\nI could not find that service. What would you like today?"
  MAIN_MENU
  else
  CHOOSE_MENU
  fi
}
CHOOSE_MENU() {
  echo -e "\nWhat's your phone number?"
  # get customer info
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  #if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
    then
    #get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    #insert new customer
    CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME') ")
  fi
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE' ")
  CUSTOMER_ID=$(echo $CUSTOMER_ID | sed 's/ //g')
  #get time
  echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED, $CUSTOMER_NAME?"
  read SERVICE_TIME
  INSERT_TIME_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id, time) VALUES ('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME') ")
  echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME." 

}
MAIN_MENU