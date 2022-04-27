## Instalando o GDB
Para instalar o GDB em distribuições Debian/Ubuntu:
```
sudo apt-get install gdb
```

## Debug utilizando o GDB
> *ATENÇÃO:* não utilizar a flag `-s` caso esteja linkando usando `ld` ("strip" vai atrapalhar o funcionamento do gdb).

Criar o executável do programa:
```
nasm -g -f elf64 prog.asm
ld -o prog prog.o     # ou gcc -o prog prog.o 
```
Após compilar o programa em Assembly, rode o GDB:
```
gdb ./prog --tui
```
Esse comando irá utilizar uma interface de terminal (flag `--tui`). Os breakpoints podem ser definidos usando o comando `break` ou `b`. Para criar um breakpoint em uma linha ou em uma label do seu programa, use o seguinte comando:
```
break <linha>   # ou break <nome-da-label> 
```
Após definição dos breakpoints, rode o programa: 
```
run
```
É importante lembrar que é possível criar breakpoints a qualquer momento da execução do programa.
Para visualizar os registradores, basta usar o comando:
```
layout regs
```
Para executar a próxima linha durante a execução do debugger, use o comando `step`: 
```
step  # ou s
```
Caso deseje avançar até o próximo breakpoint (ou até o fim da execução, caso não hajam mais breakpoints), use o comando a seguir:
```
continue  # ou c
```
Por fim, para terminar a execução do debugger, use o comando `quit` ou `q`.
Para mais detalhes do funcionamento do debugger GDB, consulte o [manual do programa](http://www.gnu.org/software/gdb/documentation/) `man gdb` e utilize o comando `help` durante a execução.
