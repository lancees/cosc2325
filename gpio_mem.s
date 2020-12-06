/********************************************************************************************
 GPIO access via memmory mapping file to controller
 RPi3 GPIO_Base address=0x3F200000
 Setting GPIO6 pin for RPi3:
 1) Set GPSEL register to configure pin as input or output:
    To assign GPIO6 pin as input we need to set GPSEL0 Register bits 18, 19, and 20 to 000
    To assign GPIO6 pin as output we need to set GPSEL0 Register bits 18, 19, and 20 to 100
 2) Set GPSET and GPCLR to turn the pin on (set) or off (clear):
    To turn GPIO6 pin on (set), write 1 to GPSET0 register bit 6
    To turn GPIO6 pin off (clear), write 1 to GPCLR0 register bit 6
*********************************************************************************************/
.global main

.extern delay			//WiringPi Function used for delays only

main:
	ldr r0,=msg
	bl printf
 
	//Setup virtual memory allocation for physical GPIO addresses
	// open(const char *pathname, int flags);
	ldr r0, .filedir	// Load "/dev/mem" location 
	ldr r1, .flags		// Load flags to set access permissions for 'open'
	bl open			// Call open function to read memory

	// mmap(void *addr, size_t length, int prot, int flags,int fd, off_t offset)
	mov r4,r0		// Store file descriptor from file read
	mov r0,#0		// Store NULL so kernel chooses the (page-aligned) addr
	mov r1,#4096		// Store Page size
	mov r2,#3		// Store protection mode
	mov r3,#1		// Store permission flag
	ldr r5, .gpiobase	// Load phsyical address base
	sub sp,sp,#8		// Create room on stack
	str r5,[sp,#4]		// Store physical address base in stack
	str r4,[sp,#0]		// Store file destriptor on stack
	bl mmap			// Call memory mapping function with above
	mov r11,r0		// Store virtual memory address returned from mmap to r11

	// close(int fd)
	ldr r0,[sp,#0]		// Reload file descriptor for close branch
	bl close		// Close file for cleanup
	add sp,sp,#8		// Restore stack pointer

 	//LED (BCM 6)
	mov r0,#1		// Set pin as OUTPUT
	lsl r0,#18		// Shift OUT bit to match BCM pin 6 (3*last digit)
	str r0,[r11,#0]		// Store OUT bit at GPSEL0 (pins 0-9, base+0)


	mov r0, #1		// Create HIGH bit for LED set
	lsl r0, #6		// Shift HIGH bit to pin (lsl BCM pin#)
	str r0, [r11,#28]	// Store shifted HIGH bit at GPSET0 (base+28)

	//Create some delay between led on/off
	ldr r0, =delayTime	// Setup 0.6 seconds for delay branch
	ldr r0,[r0]		// Reiterate address for branch
	bl delay		// Jump to delay function


	mov r8,#1		// Create HIGH bit for LED clear
	lsl r8,#6		// Shift HIGH bit to pin (lsl BCM pin#)
	str r8,[r11,#40]	// Store shifted HIGH bit at GPCLR0 (base+40)

	mov r7, #1		// Exit system call
	swi 0

.filedir:	.word	fileName	// Word variable of string name of file
.flags:		.word	1576962		// Permission flags O_RDWR|O_SYNC|O_CLOEXEC
.gpiobase:	.word	0x3F200000	// Phsyical address base of GPIO for RPi3

.data
fileName:	.asciz "/dev/mem"		// Memory file location in OS
msg:	 	.asciz "GPIO handling via mmap ...\n"
delayTime: 	.int 1600
