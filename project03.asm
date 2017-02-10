TITLE Program Template     (Project03.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID     CS 271/Project03   Date: 2/9/17
; Description: A program made to validate user input and accumulates negative int
; then preforms calculations to display and exits.

INCLUDE Irvine32.inc

; (insert constant definitions here)
LOWERLIM EQU FFFFFFFFh

.data
;Intro and instruction var
intro_msg_1 BYTE "Welcome to the Negative Accumlator, Created by Sergio Ortega-Rojas.", 0
intro_msg_2 BYTE "What is your name? ", 0
intro_msg_3 BYTE "Welcome, ", 0
instr_msg_1 BYTE "Please enter negative integers between [-100, -1].", 0
instr_msg_2 BYTE "Enter a non-negative number when you are finished to see the results.", 0
username BYTE ?
username_offset DWORD ?

; (insert variable definitions here)

.code
main PROC

;Intro and instructs User
mov edx, OFFSET intro_msg_1
call WriteString
call CrLf
mov edx, OFFSET intro_msg_2
call WriteString
;call ReadString
call CrLf
mov edx, OFFSET intro_msg_3
call WriteString
;mov edx, OFFSET username
;call WriteString
call CrLf
call CrLf
mov edx, OFFSET instr_msg_1
call WriteString
call CrLf
mov edx, OFFSET instr_msg_2
call WriteString
call CrLf

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
