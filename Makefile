all: build

build:
	nasm -f elf64 print.asm 
	nasm -f elf64 itoa.asm 

clean:
	rm *.o