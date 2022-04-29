%macro SWITCH 0

    %push   SWITCH
    %assign %$case 0

%endmacro

%macro ENDSWITCH 0

    endswitch:
    %pop    SWITCH

%endmacro

%macro CASE 1

    %ifctx SWITCH
        L%$case:

            %assign %$case %$case+1
            cmp     ecx, %1
            jne     L%$case

    %endif

%endmacro

%macro DEFAULT 0

    %ifctx SWITCH
        L%$case:
    %endif

%endmacro


%macro BREAK 0

    %ifctx SWITCH
    jmp endswitch
    %endif

%endmacro

%macro print 1
    push dword %1
    push message
    call printf
    add esp, 8
%endmacro

extern printf, exit
global  main

section .data
message db "Match: %d", 10, 0

section .text

main:

mov ecx, 50

SWITCH
    CASE 50
        mov ebx, 50
        print ebx
        BREAK
    CASE 30
        mov ebx, 30
        print ebx
        BREAK
    CASE 1
        mov ebx, 1
        print ebx
        BREAK
    CASE 2
        mov ebx, 2
        print ebx
        BREAK
    DEFAULT
        mov ebx, 10
        print ebx
        BREAK
ENDSWITCH

call exit
