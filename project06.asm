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
userAnswer BYTE 11 DUP(0)
userAnswer_offset DWORD ?

.code
main PROC
call Randomize

;Introduction
call Introduction

;showProblem
push OFFSET n_var
push OFFSET r_var
call showProblem

;getData
push OFFSET userAnswer
push SIZEOF userAnswer
push OFFSET userAnswer_offset
call getData

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

Introduction PROC

displayString title_msg
call CrLf
displayString name_msg
call CrLf
displayString program_intro
call CrLf

ret 
Introduction ENDP



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



getData PROC
push ebp
mov ebp, esp

displayString prompt_msg
mov edx, [ebp + 16]
mov ecx, [ebp + 12]
call ReadString
mov ebx, [ebp + 8]
mov [ebx], eax





pop ebp
ret 12
getData ENDP

; (insert additional procedures here)



END main
