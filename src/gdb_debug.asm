; eax = nao
; esp = stack pointer

section .text
global main
extern printf, exit ; interface com C

main:

; contador
mov ebx, 0          ; inicializa contador com 0

_loop:
    add ebx, 1      ; incrementa contador
    push ebx        ; carrega o contexto do contador
    push message    ; carrega o contexto da mensagem
    call printf     ; chama print do C
    add esp, 8      ; restaura o stack pointer
    cmp ebx, 20     ; compara contador com N
    jnz _loop       ; retorna ao loop se for diferente
    jmp _exit       ; encerra se for igual

_exit:
    call exit       ; encerra o programa

section .data
message db "Valor = %d", 10, 0    ; imprime com quebra de linha (10) e terminador (0)
