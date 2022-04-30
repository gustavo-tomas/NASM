NASM=nasm
DEBUGF=-g
TARGET=switch
RUN=run
DEBUG=gdb_debug
BUILD=./build
SRC=./src

make:
	mkdir -p $(BUILD)
	$(NASM) -f elf $(SRC)/$(TARGET).asm -o $(BUILD)/$(TARGET).o && gcc -m32 -o $(RUN) $(BUILD)/$(TARGET).o

debug:
	mkdir -p $(BUILD)
	$(NASM) $(DEBUGF) -f elf $(SRC)/$(DEBUG).asm -o $(BUILD)/$(DEGUB).o && gcc -m32 -o $(RUN) $(BUILD)/$(DEGUB).o

clean:
	rm -rf $(BUILD)
	rm -f $(RUN)
