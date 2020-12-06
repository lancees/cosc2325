// To compile this code: gcc -o blinkc blink_led.c -lwiringPi

#include <wiringPi.h> //http://wiringpi.com/
#include <stdio.h>
#include <stdlib.h>

// Wiring Pi pin 0, Physical pin 11, BCM GPIO 17
// Refer to https://pinout.xyz/ for pin information
// Type pinout command in your RPi terminal
#define GpioPin 0 

int main (void) 
{
	int loopCounter=0; //initializing while loop counter
	
  	printf("Raspberry Pi - Blinking led test in C\n");

        // wiringPiSetup (void)
	// This initialises wiringPi and assumes calling program 
	// is going to be using the wiringPi pin numbering scheme.
	// If using BCM GPIO pin numbering use wiringPiSetupGpio()
  	wiringPiSetup();

	// void pinMode (int pin, int mode) 
	// This sets the mode of a pin to either INPUT, OUTPUT, PWM_OUTPUT or GPIO_CLOCK. 
  	pinMode(GpioPin, OUTPUT);

	// void digitalWrite (int pin, int value) 
	// Writes the value HIGH or LOW (1 or 0) to the given pin which must have been previously set as an output.
	// WiringPi treats any non-zero number as HIGH, however 0 is the only representation of LOW.
  	while (loopCounter<4)
	{
		digitalWrite(GpioPin, HIGH);
		printf("...LED on\n");
    		delay(1000);
		digitalWrite(GpioPin, LOW);
		printf("LED off...\n");
		delay(1000);
		loopCounter++;
	}

  return 0;
}