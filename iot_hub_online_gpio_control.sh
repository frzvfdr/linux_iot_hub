#Shell script for controling LightLinks IOT hub over the internet
#Developed by Firouz Vafadari (FRZVFDR)
#!/bin/sh

#First export GPIO pins
#The light Links IOT hub has many GPIO pins which you can export
#In this example we just exported 2 pins

echo 1 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio1/direction
echo 2 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio2/direction

#You can use this kind of commands to automatically export GPIO pins by inputting the number

#echo $1 > /sys/class/gpio/export
#echo "out" > /sys/class/gpio/gpio$1/direction
#echo "1" > /sys/class/gpio/gpio$1/value

#Using cURL to send HTTP POST requests

#input the address of your IOT API instead lightlinks.ir in the cURL line
while :
do
IP=$(curl POST -F 'id=322' --max-time 3 https://lightlinks.ir/button/iot.php)

#catching the value in an array

a=[0,0]
b=[1,1]
c=[0,1]
d=[1,0]

#you can use switch case instead of if else statements

if [ $IP == $a ]
then
    /bin/echo "Everything is OFF"
    echo 0 >/sys/class/gpio/gpio2/value
    echo 0 >/sys/class/gpio/gpio1/value

elif [ $IP == $b ]
then
    /bin/echo "Both ON"
    echo 1 >/sys/class/gpio/gpio2/value
    echo 1 >/sys/class/gpio/gpio1/value
elif [ $IP == $c ]
then
    /bin/echo "Second On"
    echo 1 >/sys/class/gpio/gpio2/value
    echo 0 >/sys/class/gpio/gpio1/value
elif [ $IP == $d ]
then
    /bin/echo "First On"
    echo 0 >/sys/class/gpio/gpio2/value
    echo 1 >/sys/class/gpio/gpio1/value
fi
#For faster response don't use a value for sleep
#sleep 1
done