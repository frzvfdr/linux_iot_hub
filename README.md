# Light Links IOT HUB Online GPIO control

As you know [Light Links](https://lightlinks.ir) devices are based on OpenWrt which is an embedded distribution of Linux and you can simply control
the GPIO pins values over the internet from anywhere in the world!

## what this shell script does?
By uploading this script to your Light Links Router and IOT hub and inputting your IOT platform API you will be able to control the GPIO pins of the Light Links hub
over the internet, fast and agile!

## Explaining the GPIO pin mounting

First we have to export GPIO pins to /sys/class/gpio directory by echo command.
For example, in line 9 of this script we exported the GPIO pin number 1 to the system with command below :

```sh

echo 1 > /sys/class/gpio/export

```
The Light Links IOT hub has many GPIO pins which you and see the numbers of them in the products manual. You can export as many pins as you want, and the device is 
able to control various devices like relays, sensors, servo motors, etc.

In the next line we have to change the direction of the pin to "out", so we have to echo out to /sys/class/gpio/goio[pin number]/direction.
For instance, we changed the direction of the gpio number 1 to out in line 10 of the script :
```sh

echo "out" > /sys/class/gpio/gpio1/direction

```
As well you can export other pin numbers with those 2 commands.

## Explaining HTTP POST and connecting to IOT platform API
We recommend using cURL for connecting to your IOT platform API but you can use DDNS instead. 
In this script, we used cURL to send IOT hub ID by HTTP POST to the IOT platform API on our servers. 
It is required to set the max time of every cURL request to 3, but it depends on your server response, if your server is slow you have to place a larger number.

```sh

IP=$(curl POST -F 'id=322' --max-time 3 https://lightlinks.ir/button/iot.php)

```

We will save the output of the curl POST to a variable like IP in this example.
The output value of the API is a JSON array. 

> Note: Every Light Links IOT hub has a specific device id which you have to declare and send to your server.

## Checking the JSON Array and send output to GPIO
In this sample Shell for clarifying, we checked the array values with an if-else statement but you can use which case or other complicated and advanced method based
on your application.
At the end you have to give an output value to your GPIO pin number based on the scenario which you declaired for your application:

```sh
    echo 1 >/sys/class/gpio/gpio2/value
    echo 0 >/sys/class/gpio/gpio1/value
```
For instance, we use echo 1 to set gpio2 output to Active High and using 0 to set GPIO number 1 to Active Low.

## Develope your own shell scripts for Light Links IOT hub
Dear developers and IOT experts, you can just use simple shell scripts to control light links Linux based IOT hub and router and release your software on light links
app store!

**Make Powerful IOT platforms based on Light Links hardwares.**





