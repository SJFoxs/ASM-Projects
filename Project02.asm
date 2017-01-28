TITLE Fibonacci Num Generator     (Project02.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID  CS271/Project02      Date: 1/26/17
; Description: Receives Current User's name and welcomes them, afterwhich it will generate a Fibonacci sequence.
;The Fibonacci sequence is dependent on the number of Fibonacci terms the user would like displayed(1-46).

INCLUDE Irvine32.inc

UPPERLIM EQU 46
MAXTERM EQU 5

; (insert constant definitions here)

.data
welcome_intro BYTE "Welcome to the Fibonacci number generator! My name is Sergio Ortega-Rojas", 0
term_intro BYTE "How many Fibonacci terms would you like displayed?(Supports 1-46) ", 0
termvar DWORD ?
chkdata BYTE "Currently checking input....", 0
invalidterm BYTE "This is an invalid term, please try again.", 0
validterm BYTE "This is a valid term, continuing.", 0
curvar DWORD 1
prevar DWORD 0
nextvar DWORD ?
loopvar DWORD ?
segvar DWORD ?
breakterm BYTE "     ", 0

; (insert variable definitions here)

.code
main PROC

;Introduction to the program and receives number of terms to display
mov edx, OFFSET welcome_intro
call WriteString

__termchk:
call CrLf
mov edx, OFFSET term_intro
call WriteString
call ReadInt
mov termvar, eax
call CrLf

;Runs the input to see if it is valid.
mov edx, OFFSET chkdata
call WriteString
call CrLf
mov edx, termvar
cmp edx, UPPERLIM
jg __msg1

jmp __msg2

;Invalid Input, try again
__msg1:
mov edx, OFFSET invalidterm
call WriteString
jmp __termchk

;Valid term, continue
__msg2:
mov edx, OFFSET validterm
call WriteString
call CrLf

mov eax, termvar
mov edx, 0
div MAXTERM
mov loopvar, eax
mov segvar, edx

;mov ecx, loopvar 

__part1:
cmp ecx, 0
je __part2
dec loopvar
jmp __calc

;Calculate terms F_n = F_n-1 + F_n-2
__calc:
mov eax, curvar
call WriteDec
call CrLf
mov eax, curvar
add eax, prevar
mov nextvar, eax
mov eax, curvar
mov prevar, eax
mov eax, nextvar
mov curvar, eax
jmp __part2

__part2:
loop __part1
mov edx, OFFSET breakterm
call WriteString
call CrLf

;cmp curvar, UPPERLIM
;jle __calc

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
