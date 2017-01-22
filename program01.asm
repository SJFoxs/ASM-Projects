TITLE Simple Arithmetic     (project01.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID  CS271/Project 01       Date:1/15/17
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
intro BYTE "Welcome to the Simple Arithmetic Program. My name is Sergio Ortega!", 0
prompt_num1 BYTE "Please enter the first number: ", 0
numvar1 DWORD ?
prompt_num2 BYTE "Please enter the second number: ", 0
numvar2 DWORD ?
addvar DWORD ?
subvar DWORD ?
mulvar DWORD ?
divvar DWORD ?
remvar DWORD ?
result_add BYTE "Adding int 1 and int 2 is: ", 0
result_sub BYTE "Subtracting int 1 from int 2 is: ", 0
result_mul BYTE "Multiplying int 1 with int 2 is: ", 0
result_div BYTE "Dividing int 1 with int 2 results in ", 0
result_rem BYTE " and a remainder of ", 0
repeat_chk BYTE "Would you like to do this again(Enter 1 for yes)? ", 0
repvar DWORD 1
outro BYTE "Excellent work! Until next time", 0
; (insert variable definitions here)

.code
main PROC

;Introduce Program and myself
mov edx, OFFSET intro
call WriteString
call CrLf

__prog:

;Prompts for var 1
mov edx, OFFSET prompt_num1
call WriteString
call ReadInt

;Moves eax register int to var 1
mov numvar1, eax

;Prompts for var 2
mov edx, OFFSET prompt_num2
call WriteString
call ReadInt

;Moves eax register int to var 2
mov numvar2, eax

;Add var 1 to the eax register(currently holding var 2) then writes the result for the addition
add eax, numvar1
mov addvar, eax

;The eax register(currently holding var 1) is subtracted by var 2 then writes the result for the subtraction
mov eax, numvar1
sub eax, numvar2
mov subvar, eax

;The eax register(currently holding var 1) is multiplied by var 2 then writes the result for the multiplication
mov eax, numvar1
mul numvar2
mov mulvar, eax

;The eax register(currently holding var 1) is divided by var 2 then writes the result for division
mov eax, numvar1
mov edx, 0
div numvar2
mov divvar, eax
mov remvar, edx

;Prints out the results that were done by the calculations
;(Addition)
mov edx, OFFSET result_add
call WriteString
mov eax, addvar
call WriteDec
call CrLf

;(Subtraction)
mov edx, OFFSET result_sub
call WriteString
mov eax, subvar
call WriteDec
call CrLf

;(Multiplication)
mov edx, OFFSET result_mul
call WriteString
mov eax, mulvar
call WriteDec
call CrLf

;(Division w/Remainder)
mov edx, OFFSET result_div
call WriteString
mov eax, divvar
call WriteDec
mov edx, OFFSET result_rem
call WriteString
mov eax, remvar
call WriteDec
call CrLf

mov edx, OFFSET repeat_chk
call WriteString
call readInt
cmp repvar, eax
;call ClrScr
je __prog


; (insert executable instructions here)
__end:
mov edx, OFFSET outro
call WriteString
call CrLf
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
