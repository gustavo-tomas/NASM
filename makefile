NASM=nasm
DEBUG=-g
TARGET=main
BUILD=./build
SRC=./src

make:
	mkdir $(BUILD)
	$(NASM) $(DEBUG) -F dwarf -f elf64 $(SRC)/$(TARGET).asm -o $(BUILD)/$(TARGET).o
	ld -o run $(BUILD)/$(TARGET).o

clean:
	rm -rf $(BUILD)
	rm -f run