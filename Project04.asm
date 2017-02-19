TITLE Composite Numbers     (Project04.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID  CS271/Project 04    Date: 2/18/17
; Description: This program is meant to accept an input from a range of 1 to 400. 
; Afterwards it displays an equivalent amount of composite numbers then proforms an outro.

INCLUDE Irvine32.inc

; (insert constant definitions here)
UPPERLIM = 400

.data
;Introduction Var
intro_msg BYTE "Welcome to Composite Numbers, programmed by yours truly Sergio Ortega-Rojas.", 0
instr_msg_1 BYTE "Enter the number of composite numbers you would like to see.", 0
instr_msg_2 BYTE "I'll accept orders for up to 400 composites.", 0

;getUserData Var
enternum_msg BYTE "Enter the number of composites to display [1 .. 400]: ", 0
usernum DWORD ?
checkvar DWORD 0 ;0 is false and 1 is true
errormsg BYTE "Out of range. Try again.", 0

;Farewell Var
outro_msg BYTE "Results certified by Sergio Ortega-Rojas", 0

; (insert variable definitions here)

.code
main PROC

call introduction
call getUserData
;call showComposites
; (insert executable instructions here)
call farewell

	exit	; exit to operating system
main ENDP


;Descriptions: Introduction to the user for the program
;Receives: N/A
;Returns: N/A
;Preconditions: None
;Registers Changed: EDX
introduction PROC

mov edx, OFFSET intro_msg
call WriteString
call CrLf
call CrLf
mov edx, OFFSET instr_msg_1
call WriteString
call CrLf
mov edx, OFFSET instr_msg_2
call WriteString
call CrLf
call CrLf

ret
introduction ENDP


;Descriptions: 
;Receives: Usernum
;Returns: Usernum
;Preconditions: None
;Registers Changed: EAX, EDX
getUserData PROC

__loop1:
mov edx, OFFSET enternum_msg
call WriteString
call ReadInt
mov usernum, eax

call validate

cmp checkvar, 1
jne __loop1


ret
getUserData ENDP


;Descriptions: 
;Receives:
;Returns:
;Preconditions:
;Registers Changed:
validate PROC
cmp usernum, UPPERLIM
jg __errormsg
cmp usernum, 1
jl __errormsg

mov checkvar, 1
jmp __exit

__errormsg:
mov edx, OFFSET errormsg
call WriteString
call CrLf
call CrLf

__exit:
ret
validate ENDP


;Descriptions: 
;Receives:
;Returns:
;Preconditions:
;Registers Changed:
showComposites PROC


ret
showComposites ENDP


;Descriptions: 
;Receives:
;Returns:
;Preconditions:
;Registers Changed:
isComposites PROC


ret
isComposites ENDP


;Descriptions: 
;Receives:
;Returns:
;Preconditions:
;Registers Changed:
farewell PROC
call CrLf
mov edx, OFFSET outro_msg
call WriteString
call CrLf


ret
farewell ENDP
; (insert additional procedures here)

END main
