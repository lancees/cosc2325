#include <iostream>

/* This function is written in assembly */
extern "C" long f1(void);

int main() {
	std::cout<<"Calling assembly now...\n";
	long rc=f1();
	std::cout<<"Back from assembly.  Returned "<<rc<<"\n";
	return 0;
}

