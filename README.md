# NASM
Repositório de duas tarefas:
- Exemplificar o uso do debugger GDB
- Simular o comando `switch` usando macros

## Compilando os arquivos
### Linux
Existem dois arquivos na pasta `src`: um para visualizar o funcionamento do gdb, chamado de `gdb_debug.asm` e outro para testar o switch, chamado de `switch.asm`.

- Para compilar o arquivo de debug, usar ``` make debug ```
- Para compilar o arquivo do switch, usar ``` make ```
- Para remover os arquivos gerados pela compilação, use o comando `make clean`.

Depois, basta rodar o executável com `./run`.

### Windows
Além dos aquivos citados acima, exitem os arquivos `gdb_debug_win.asm` e `switch_win.asm` compatíveis com a plataforma Windows.

- Para compilar o arquivo de debug, usar ``` make debug -f makefile.win ```
- Para compilar o arquivo do switch, usar ``` make -f makefile.win ```
- Para remover os arquivos gerados pela compilação, use o comando `make clean -f makefile.win`.

Depois, basta rodar o executável com `./run`.

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
Para executar a próxima linha durante a execução do debugger, use o comando `step`: 
```
step  # ou s
```
Caso deseje avançar até o próximo breakpoint (ou até o fim da execução, caso não hajam mais breakpoints), use o comando a seguir:
```
continue  # ou c
```

### Conteúdo dos registradores
É importante lembrar que é possível criar breakpoints a qualquer momento da execução do programa.
Para visualizar os registradores, basta usar o comando:
```
layout regs
```

### Conteúdo da memória
Para ver o conteúdo da memória é um pouco mais complexo. Primeiro, é preciso listar as variáveis definidas:
```
i var
```
Em seguida, é preciso usar o comando `x` com os parâmetros do tamanho e do tipo de dado na forma:
```
x/<tam><tipo> &<var>  # ou &<endereço>
```
Então, para ver o conteúdo da variável `so_memeto_emencrenca` (que fica no endereço 0x2000, por exemplo) no formato de 4 bytes:
```
x/4b &so_memeto_emencrenca  # ou &0x2000
```

### Encerrar o GDB
Por fim, para terminar a execução do debugger, use o comando `quit` ou `q`.
Para mais detalhes do funcionamento do debugger GDB, consulte o [manual do programa](http://www.gnu.org/software/gdb/documentation/) `man gdb` e utilize o comando `help` durante a execução.

