# A Simple Assembly Program Using NASM

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/tyeborg/simple-assembly-program)
![GitHub top language](https://img.shields.io/github/languages/top/tyeborg/simple-assembly-program)
![GitHub last commit](https://img.shields.io/github/last-commit/tyeborg/simple-assembly-program)

The objective of this project is to write a simple assembly program and compile it to run on the computer. For this project, the Linux Azure Labs machine was utilized.

**Project Code Requirements**:
* Your assembly code must prompt the user to enter a choice out of four possible choices (`1`, `2`, `3`, or `q`).
* The program should continue prompting the user to enter choices until `q` is entered.
    * `1` displays `Welcome to my assembly program` onto the terminal.
    * `2` displays `The second choice` onto the terminal.
    * `3` displays `The last choice` onto the terminal.
    * `q` displays `Goodbye` onto the terminal and ultimately ends the program.
* Add program precautions/account for erroneous input from the user.

## Languages & Tools Utilized

<p float="left">
  <img src="https://user-images.githubusercontent.com/96035297/186022424-f96144ad-7b39-4add-a0dc-3c0ec400124f.png" height="50" width="50" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linux/linux-original.svg" height="50" width="50" /> 
  <img src="https://user-images.githubusercontent.com/96035297/186023583-c38342aa-6d47-4fda-967a-5844b40c7dd3.png" height="50" width="50" />
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/96035297/186022424-f96144ad-7b39-4add-a0dc-3c0ec400124f.png" height="50" width="50" />
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=linux,powershell" />
  </a>
</p>

## Running the Assembly Program

1. Run Linux Azure Labs virtual machine if you are not using a Linux operating system.
2. Open PowerShell and choose your desired location/directory.
3. Use `nano` to enter the following file: `assembly-program.asm`

```bash
$ nano assembly-program.asm
```

4. Copy and paste the following assembly code into the newly created file [assembly-program.asm]:

```assembly
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
```

5. Save the program and exit nano.
6. To build and run the program perform the following on the commands:

```bash
$ nasm -f elf32 assembly-program.asm
$ gcc -m32 assembly-program.o
$ ./a.out
```

## Assembly Code Explaination

There is quite a bit of code to explain, so let's start at the top:

* `global` is used by NASM to declare externally visible values. As the program requires a place to start running from, we declare `main` as global. main is just a label we put in the program.
* `SECTION` is used to define different sections of the code. This allows the assembler to recognise different parts of the program. We have two sections: `.text` is for the code, and `.data` is for the data (variables).
* We have used two operations in this program:
    * `mov` moves data into a location from another location. The format is `mov destination, source`.
    * `int` is an interrupt, where we ask the operating system to do something for us.
* In the `.data` section we declare any values, such as our message, `msg`, to print and its length, `len`.
    * `db` means *Declare Bytes*. The NASM assembler will convert the text into bytes for us. `0xa`, hexidecimal for 10, is a line feed in ASCII.
    * `equ` declares a constant value. $ represents the current memory position in the assembly, so `$ - msg`, where `msg` is the memory address where our string was declared, tells us how long the message is in bytes.
    
| Operation   |  Operands   |  Description  |  Example  |
|   :----:    |    :----:   |     ---       |  :----:   |
|`cmp`        |*destination, source*             |Compares the destination and source setting flags inside the processor based on the outcome of the comparison.               |`cmp eax, ebx`           |
|`jmp`             |*label*             |Jumps to the label in the program.               |`jmp LOOP`           |
|`je`             |*label*             |Jumps if the compared values were equal.               |`je LOOP`           |
|`jz`             |*label*             |Jumps if the last operation led to zero result.               |`jz LOOP`           |
|`jg`             |*label*             |Jumps if the *destination* was greater than *source* in the comparison.               |`jg LOOP`           |
|`jge`             |*label*             |Jumps if the destination was greater than or equal to source in the comparison.               |`jge LOOP`           |
|`jl`             |*label*             |Jumps if the destination was less than the source in the comparison.               |`jl LOOP`           |

**These are simple operations that can be reused to perform these printing and program exit operations.**

## Project Evaluation

* **Syntax**: `Excellent` (Program compiles and contains no evidence of misunderstanding or misinterpreting the syntax of the language)
* **Solution**: `Excellent` (A completed solution meeting all the specifications.)
* **Correctness**: `Excellent` (Program produces correct answers or appropriate results for all inputs tested)
* **Logic**: `Excellent` (Program logic is correct with no known boundary errors, and no redundant or contradictory conditions.)
* **Clarity**: `Excellent` (Program contains appropriate documentation for all major functions, variables, or non-trivial algorithms. Formatting, indentation, and other white space aids readability.)
* **Robustness**: `Excellent` (Program handles erroneous input gracefully; action is taken without surprising the user. Boundary cases are considered and tested.)
* **Submission**: `Excellent` (Correct files submitted only and with correct names.)

**Grade**: 100.00 / 100.00
