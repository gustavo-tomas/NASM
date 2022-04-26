; guarda o valor 1 em bx
%macro SWITCH 1

    %push   SWITCH
    mov     bx, %1

%endmacro

%macro 
%endmacro

; compara o valor de uma variável com o valor em bx(base register)
%macro CASE 1

    %push   CASE
    cmp     bx, %1

%endmacro

%macro DEFAULT 0
%endmacro

%macro BREAK 0
%endmacro


global  _start
section .text
_start:

%macro SWITCH 1

%endmacro    