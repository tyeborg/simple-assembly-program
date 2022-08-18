global main
extern printf                                            ; ask to include printf function

SECTION .data
    prompt db "Please enter a choice: ",0xa,0x0          ; set the prompt
    input_1 db "Welcome to my assembly program.",0xa,0x0 ; set variable to statement
    input_2 db "The second choice.",0xa,0x0              ; set variable to statement
    input_3 db "The last choice.",0xa,0x0                ; set variable to statement
    input_q db "Goodbye!",0xa,0x0                        ; set variable to statement
    error_input db "ERROR! Please try again.",0xa,0x0    ; set variable to statement 

SECTION .bss
    input resb 2                                         ; reserve two bytes for the user input

SECTION .text
main:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push prompt                                          ; push prompt onto stack
    call printf                                          ; call print to display prompt
    int 0x80                                             ; call the operating system
    mov eax, 3                                           ; set system call to perform a read (SYS_READ)
    mov ebx, 0                                           ; set input stream to standard input (STDIN)
    mov ecx, input                                       ; set the location to read into
    mov edx, 2                                           ; set the number of bytes to read, 2
    int 0x80                                             ; call the operating system
    call welcome                                         ; call the 'welcome' subroutine
    call second_choice                                   ; call the 'second_choice' subroutine
    call last_choice                                     ; call the 'last_choice' subroutine
    call goodbye                                         ; call the 'goodbye' subroutine
    call error                                           ; call the 'error' subroutine

welcome:
    mov al, [input]                                      ; move input into the al register
    cmp al, '1'                                          ; compare al register to 1
    je end_welcome                                       ; if input equals 1 jump to 'end_welcome'
    ret                                                  ; return to where call was made from if not equal

second_choice:
    mov al, [input]                                      ; move input into the al register
    cmp al, '2'                                          ; compare al register to 2
    je end_second                                        ; if input equals 2 jump to 'end_second'
    ret                                                  ; return to where call was made from if not equal

last_choice:
    mov al, [input]                                      ; move input into the al register 
    cmp al, '3'                                          ; compare al register to 3
    je end_last                                          ; if input equals 3 jump to 'end_last'
    ret                                                  ; return to where the call was made from if not equal

goodbye:
    mov al, [input]                                      ; move input into the al register
    cmp al, 'q'                                          ; compare al register to q
    je end_goodbye                                       ; if input equals q jump to 'end_goodbye'
    ret                                                  ; return to where the call was made from if not equal

error:
    mov al, [input]                                      ; move input into the al register
    cmp al, ''                                           ; compare al register with ''
    jne end_error                                        ; if not equal with '' jump to 'end_error'

end_welcome:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push input_1                                         ; push 'input_1' onto stack
    call printf                                          ; call printf
    jmp main                                             ; jump to main after print

end_second:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push input_2                                         ; push 'input_2' onto stack
    call printf                                          ; call printf
    jmp main                                             ; jump to main after print

end_last:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push input_3                                         ; push 'input_3' onto stack
    call printf                                          ; call printf
    jmp main                                             ; jump to main after print

end_goodbye:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push input_q                                         ; push 'input_q' onto stack
    call printf                                          ; call printf
    jmp end                                              ; jump to end subroutine

end_error:
    mov eax, 4                                           ; write to an output stream (SYSWRITE)
    mov ebx, 1                                           ; file descriptor (STDOUT)
    push error_input                                     ; push 'error_input' onto stack
    call printf                                          ; call printf
    jmp main                                             ; jump to main after print

end:
    mov eax, 1                                           ; set system call for exit
    int 0x80                                             ; call the operating system


