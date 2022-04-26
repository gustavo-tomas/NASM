## Instalando o GDB
Para instalar o GDB, basta usar
```
sudo apt-get install gdb
```

## Debug utilizando o GDB
__ATENÇÃO__ não utilizar a flag `-s` ("strip" vai atrapalhar o funcionamento do gdb).

Compilar o programa com os comandos:
```
nasm -g -F dwarf -f elf64 prog.asm
ld -o prog prog.o
```
Em seguida, rodar o gdb:
```
gdb ./prog --tui
```
Esse comando irá utilizar uma interface de terminal (flag `--tui`). Os breakpoints podem ser definidos por 
```
break <linha>
```
E o programa executado com 
```
run
```
Para visualizar os registradores, basta usar
```
layout regs
```
Para avançar um passo, usar 
```
step
```
Para executar o restante do código, usar
```
continue
```