TITLE Program Template     (Project03.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID     CS 271/Project03   Date: 2/9/17
; Description: A program made to validate user input and accumulates negative int
; then preforms calculations to display and exits.

INCLUDE Irvine32.inc

; (insert constant definitions here)
LOWERLIM EQU 0

.data
;Intro and instruction var
intro_msg_1 BYTE "Welcome to the Negative Accumlator, Created by Sergio Ortega-Rojas.", 0
intro_msg_2 BYTE "What is your name? ", 0
intro_msg_3 BYTE "Welcome, ", 0
instr_msg_1 BYTE "Please enter negative integers between [-100, -1].", 0
instr_msg_2 BYTE "Enter a non-negative number when you are finished to see the results.", 0

;Receive var
enumber_msg BYTE "Enter number: ", 0

;User inputted var
username BYTE 21 DUP(0)
username_offset DWORD ?
uintinput SDWORD ?

;Display results var
valid_num_msg_1 BYTE "You entered ", 0
valid_num_msg_2 BYTE " valid numbers.", 0
sum_num_msg BYTE "The sum of your valid numbers is ", 0
avg_num_msg BYTE "The rounded average is ", 0
valid_num DWORD 0
sum_num SDWORD 0
avg_num SDWORD 0
msg1 BYTE "Unit is less than 0", 0

;Outro Var
outro_msg_1 BYTE "Thank you for using the Negative Accumlator, have a fanatastic day ", 0
outro_msg_2 BYTE "!", 0
; (insert variable definitions here)

.code
main PROC

;Intro and instructs User
mov edx, OFFSET intro_msg_1
call WriteString
call CrLf
mov edx, OFFSET intro_msg_2
call WriteString
mov edx, OFFSET username
mov ecx, SIZEOF username
call ReadString
mov username_offset, eax
call CrLf
mov edx, OFFSET intro_msg_3
call WriteString
mov edx, OFFSET username
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

;Receive User input
mov edx, OFFSET enumber_msg
call WriteString
call ReadInt
mov uintinput, eax
cmp eax, LOWERLIM
jl __datavalidation
jmp __displayresults

__datavalidation:

mov edx, OFFSET msg1
call WriteString
call CrLf

;Display Results
__displayresults:
mov edx, OFFSET valid_num_msg_1
call WriteString
mov eax, valid_num
call WriteInt
mov edx, OFFSET valid_num_msg_2
call WriteString
call CrLf
mov edx, OFFSET sum_num_msg
call WriteString
mov eax, sum_num
call WriteInt
call CrLf
mov edx, OFFSET avg_num_msg
call WriteString
mov eax, avg_num
call WriteInt
call CrLf


; (insert executable instructions here)
;Outro
call CrLf
mov edx, OFFSET outro_msg_1
call WriteString
mov edx, OFFSET username
call WriteString
mov edx, OFFSET outro_msg_2
call WriteString
call CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
