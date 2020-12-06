// To compile this code: gcc -o blink_asm blink_led_asm.c -lwiringPi

#include <wiringPi.h> //http://wiringpi.com/
#include <stdio.h>
#include <stdlib.h>

// Wiring Pi pin 22, Physical pin 31, BCM GPIO 6
// Refer to https://pinout.xyz/ for pin information
// Type pinout command in your RPi terminal
#define GpioPin 22 

int main (void) 
{
	int loopCounter=0; //initializing while loop counter
  	
	printf("Raspberry Pi - Blinking led test in C with embedded assembly\n");

        // wiringPiSetup (void)
	// This initialises wiringPi and assumes calling program 
	// is going to be using the wiringPi pin numbering scheme.
	// If using BCM GPIO pin numbering use wiringPiSetupGpio()
  	wiringPiSetup();

	// void pinMode (int pin, int mode) 
	// This sets the mode of a pin to either INPUT, OUTPUT, PWM_OUTPUT or GPIO_CLOCK. 
  	pinMode(GpioPin, OUTPUT);

  	while(loopCounter<4){
		//digitalWrite(GpioPin, HIGH);
		__asm("mov r0, #0");		//GPIO pin 0
		__asm("mov r1, #1");		//Pin mode=HIGH 
		__asm("bl digitalWrite");
		printf("...LED on\n");
    		delay(1000);
		//digitalWrite(GpioPin, LOW);
		__asm("mov r0, #0");		//GPIO pin 0
		__asm("mov r1, #0");		//Pin mode=HIGH 
		__asm("bl digitalWrite");
		printf("LED off...\n");
		delay(1000);
		loopCounter++;
	}

  return 0;
}
