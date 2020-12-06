.text			//this is executable code

.global f1		//make f1 visible to linker

f1:			//function starts here
    	push {r4,lr}   	//save link register

    	adr r0, my_str	//compute address of string
    	bl puts        	//call C library function (Branch and Link)

	mov r0, #0	//our return value
    	pop {r4,pc}	//clean up and return from function


my_str:	.asciz	"Hello from ARM!"

