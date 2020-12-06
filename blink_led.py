# gpiozero library uses Broadcom (BCM) pin numbering for the GPIO pins
# https://gpiozero.readthedocs.io/en/stable/
from gpiozero import LED #importing LED interface from gpiozero

from time import sleep

loopCounter=0 # while loop counter

led=LED(17) #using BCM GPIO 17

print("Raspberry Pi - Blinking led test in Python")

while loopCounter<4:
        led.on()                #Turn on led
        print("...LED on")
        sleep(1)                #Wait 1 second
        led.off()               #Turn off led
        print("LED off...")
        sleep(1)                #Wait 1 second
        loopCounter+=1
