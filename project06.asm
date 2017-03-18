TITLE Combinations     (project06.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID       CS271/Project6B          Date: 03/14/2017
; Description:

INCLUDE Irvine32.inc

displayString MACRO msg

push edx
mov edx, OFFSET msg
call WriteString
;call CrLf
pop edx

ENDM 

; (insert constant definitions here)

.data

; (insert variable definitions here)

;Introduction Variables
title_msg BYTE "Welcome to the Combinations Calculator", 0
name_msg BYTE "Implemented by Sergio Ortega-Rojas", 0
program_intro BYTE "This program gives you a combinations problem, enter an answer and then you'll be judged.", 0

;showProblem Variables
n_var DWORD ?
r_var DWORD ?
problem_msg BYTE "Problem:", 0
num_msg_01 BYTE "Number of elements in the set: ", 0
num_msg_02 BYTE "Number of elements to choose from the set: ", 0

;getData Variables
prompt_msg BYTE "How many ways can you choose? ", 0
tempvar DWORD ?
userAnswer BYTE 11 DUP(0)
userAnswer_offset DWORD ?

;Combinations Variables
result_var DWORD ?

;showResults Variables
result_msg_01 BYTE "There are ", 0
result_msg_02 BYTE " combinations of ", 0
result_msg_03 BYTE " items from a set of ", 0
result_msg_04 BYTE ".", 0

;checkRepeat Variables
repeat_msg BYTE "Another problem? (y/n): ", 0
invalid_msg BYTE "Invalid Response.", 0
repeatAnswer BYTE 20 DUP(0)
repeatAnswer_offset DWORD ?
repeatTF DWORD 0

;main Variables
exit_msg BYTE "OK .... Goodbye!", 0

.code
main PROC
call Randomize

;Introduction
call Introduction

__repeat_set:
;showProblem
push OFFSET n_var
push OFFSET r_var
call showProblem

;getData
push OFFSET tempvar
push OFFSET userAnswer
push SIZEOF userAnswer
push OFFSET userAnswer_offset
call getData

;combinations
push n_var
push r_var
push OFFSET result_var
call combinations

;showResults
push tempvar
push n_var
push r_var
push result_var
call showResults

;checkRepeat
push OFFSET repeatTF
push OFFSET repeatAnswer
push SIZEOF repeatAnswer
push OFFSET repeatAnswer_offset
call checkRepeat

; (insert executable instructions here)
cmp repeatTF, 1
je __repeat_set

displayString exit_msg
call CrLf

	exit	; exit to operating system
main ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
Introduction PROC

displayString title_msg
call CrLf
displayString name_msg
call CrLf
displayString program_intro
call CrLf
call CrLf

ret 
Introduction ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
showProblem PROC
push ebp
mov ebp, esp

__random_n:
mov eax, 12
call RandomRange
cmp eax, 3
jge __withinRange
jmp __random_n

__withinRange:
mov ebx, [ebp + 12]
mov [ebx], eax

__random_r:
mov eax, [ebx]
mov ebx, [ebp + 8]
mov ecx, [ebp + 12]
mov edx, [edx]
call RandomRange
cmp eax, edx
je __displayProb
inc eax
mov [ebx], eax

__displayProb:
displayString problem_msg
call CrLf

displayString num_msg_01

mov ebx, [ebp + 12]
mov eax, [ebx]
call WriteDec
call CrLf

displayString num_msg_02

mov ebx, [ebp + 8]
mov eax, [ebx]
call WriteDec
call CrLf

pop ebp
ret 8
showProblem ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
getData PROC
push ebp
mov ebp, esp

displayString prompt_msg
mov edx, [ebp + 16]
mov ecx, [ebp + 12]
call ReadString
mov ebx, [ebp + 8]
mov [ebx], eax

mov esi, [ebp + 16]
;mov ebx, [ebp + 20]
;call ReadInt
;mov [ebx], eax




pop ebp
ret 12
getData ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
combinations PROC
push ebp
mov ebp, esp

mov eax, 1
mov ecx, 1
mov ebx, [ebp + 16]

push eax
push ebx
call factorial

mov eax, ecx
push eax

mov eax, 1
mov ecx, 1
mov ebx, [ebp + 12]

push eax
push ebx
call factorial

mov ebx, ecx
push ebx

mov ebx, [ebp + 16]
mov eax, [ebp + 12]

sub ebx, eax

mov eax, 1
mov ecx, 1
push eax
push ebx
call factorial

mov eax, ecx
pop ebx
mul ebx
mov ebx, eax

pop eax
cdq
div ebx

mov ebx, [ebp + 8]
mov [ebx], eax


pop ebp
ret 12
combinations ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
factorial PROC
push ebp
mov ebp, esp

mov ebx, [ebp + 8]
cmp ebx, 1
jle __exit_req
mov eax, [ebp + 12]
mul ebx
mov ecx, eax
push eax
dec ebx
push ebx
call factorial

__exit_req:
pop ebp
ret 8
factorial ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
showResults PROC
push ebp
mov ebp, esp

call CrLf
displayString result_msg_01
mov eax, [ebp + 8]
call WriteDec
displayString result_msg_02
mov eax, [ebp + 16]
call WriteDec
displayString result_msg_03
mov eax, [ebp + 12]
call WriteDec
displayString result_msg_04
call CrLf

pop ebp
ret 16
showResults ENDP



;Descriptions: 
;Receives: 
;Returns: 
;Preconditions: 
;Registers Changed: 
checkRepeat PROC
push ebp
mov ebp, esp

call CrLf
displayString repeat_msg
mov edx, [ebp + 16]
mov ecx, [ebp + 12]
call ReadString
mov ebx, [ebp + 8]
mov [ebx], eax



pop ebp
ret 16
checkRepeat ENDP

; (insert additional procedures here)



END main
