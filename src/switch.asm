; guarda o valor 1 em bx
%macro SWITCH 1

    %push   SWITCH      ; Salva o contexto do switch
    %assign %$case 1    ; Carrega o primeiro valor do primeiro case com 1
    mov eax, dword %1   ; 
    mov edx, dword 0    ; Move um 0 de 4 bytes para o registrador edx (registrador de dados) 

%endmacro

;
%macro ENDSWITCH 0
    
    %ifctx SWITCH                ; Verifica se tem valor na pilha de contexto
        %$break:                 ; Label para o break
        %ifndef __DEFAULT        ; Verifica o DEFAULT
            %$next%$case:        ; Caso contrário, se torna 0
        %endif
    
        mov edx, dword 0         ; Reseta o valor edx
        %pop SWITCH              ; Remove o conteudo de switch da pilha
    ;ACHO Q NEM PRECISA do undef
        %undef __DEFAULT         ; Apaga a macro  __DEFAULT 
    %endif

%endmacro

; compara o valor de uma variável com o valor em bx(base register)
%macro CASE 1

    %push   CASE
    cmp     bx, %1

%endmacro


%macro DEFAULT 0

    %ifctx SWITCH
        %define __DEFAULT    
        %$next%$case:
    %endif

%endmacro


%macro BREAK 0
    %ifctx SWITCH           ; verifica se o contexto do switch esta salvo
        mov edx, dword 0    ; 
        jmp %$break         ; pula para a label break
    %elifctx IF             ; TODO: ver se esse elif pode ser retirado
        jmp %$break
    %endif
%endmacro

; macro para imprimir
%macro print 1
    push dword %1
    push message
    call printf
    add esp, 8
%endmacro


section .text
global main
extern printf, exit

main:

SWITCH <reg>
    CASE 1
        print <reg>
        inc <reg>
        BREAK
    CASE 2
        print <reg>
        inc <reg>
        BREAK
    DEFAULT
        print <reg> ; imprime -1 ?
ENDSWITCH

call exit   ; encerra o programa

section .data
message db "Valor = %d", 10, 0    ; imprime com quebra de linha (10) e terminador (0)
