NASM=nasm
DEBUGF=-g
TARGET=main
RUN=run
DEBUG=debug
BUILD=./build
SRC=./src

make:
	mkdir -p $(BUILD)
	$(NASM) $(DEBUGF) -f elf $(SRC)/$(TARGET).asm -o $(BUILD)/$(TARGET).o && gcc -m32 -o $(RUN) $(BUILD)/$(TARGET).o

clean:
	rm -rf $(BUILD)
	rm -f $(RUN)