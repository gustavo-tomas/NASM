;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UnB - Brasilia - Brasil                        ;
; Abril - 2022                                   ;
;                                                ;
; Simulacao do Switch Case usando macros em NASM ;
;                                                ;
; Arthur Augusto Pinto Cunha - 160113008         ;
; Cintia Leal Rodrigues - 170125696              ;
; Gustavo Tomas de Paula - 190014148             ;
; Luiz Carlos Schonarth Junior - 190055171       ;
; Rafael Henrique Nogalha de Lima - 190036966    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Forma do switch:
; SWITCH
;       CASE 1
;           ; faz alguma coisa
;           BREAK 
;       ...
;       ...
;       CASE N
;           ; faz outra coisa
;           BREAK
;       DEFAULT
;           ; faz aquela coisa
;           BREAK
; ENDSWITCH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; O switch verifica se algum case casa com o valor do registrador "ebx".   ;
; Se for bem sucedido, executa o codigo do case e depois encerra o switch. ;
; Caso contrario, executa o codigo no caso default e depois encerra.       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%macro SWITCH 0         
    %push   SWITCH      ; Salva o contexto
    %assign %$case 0    ; Atribui 0 ao case inicial 
%endmacro

%macro ENDSWITCH 0      
    endswitch:          
    %pop    SWITCH      ; Remove da pilha o contexto do switch
%endmacro

%macro CASE 1
    %ifctx SWITCH       ; Verifica se o contexto for o switch
        L%$case:
            %assign %$case %$case+1     ; Atribui case = case + 1 apos label L$case
            cmp     ebx, %1             ; Compara o valor do reg ecx ao valor passado como argumento
            jne     L%$case             ; Pula para o proximo CASE caso a comparacao de errado
    %endif
%endmacro

%macro DEFAULT 0
    %ifctx SWITCH       ; Verifica o contexto do switch
        L%$case:        ; Label para case DEFAULT, sempre deve ser a ultima
    %endif
%endmacro

%macro BREAK 0
    %ifctx SWITCH       ; Verifica o contexto do switch
        jmp endswitch   ; Pula para o fim do switch 
    %endif
%endmacro

; Macros auxiliares
%macro print 1
    push dword %1   ; Push na stack com o valor armazenado no registrador passado como argumento 
    push message    ; Push na stack da mensagem declarada na secao de dados
    call printf     ; Chama funcao printf C
    add esp, 8      ; Reinicia ponteiro para a stack
%endmacro

%macro print_not_found 0
    push not_found  ; Push na stack da mensagem de erro declarada na secao de dados
    call printf     ; Chama funcao printf C
    add esp, 4      ; Reinicia o ponteiro para a stack
%endmacro

extern printf, exit
global main

section .data
message db "Match: %d", 10, 0  ;10,  mensagem a ser mostrada no case
not_found db "Sem match - O numero e par", 10, 0
section .text

main:

mov ebx, -1  ; Inicializa o contador
loop:
    add ebx, 1      ; Incrementa contador

    SWITCH
        CASE 1
            mov eax, 1
            print eax
            BREAK
        CASE 3
            mov eax, 3
            print eax
            BREAK
        CASE 5
            mov eax, 5
            print eax
            BREAK
        CASE 7
            mov eax, 7
            print eax
            BREAK
        CASE 9
            mov eax, 9
            print eax
            BREAK
        DEFAULT
            print_not_found
            BREAK
    ENDSWITCH

    cmp ebx, 10     ; Compara contador com N
    jne loop        ; Goto label loop caso a comparacao nao de certo

call exit
