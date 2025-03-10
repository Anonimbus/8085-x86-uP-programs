;Write a program to find the sum of the following series up to the terms specified by the user and display the result in decimal format. (also try to display the sum in Hex format)  2 x 4 + 3 x 6 + ... to n terms

TITLE SUM FROM 1 TO N
.MODEL SMALL
.DATA
STRLEN DB 8
STRSZ DB ?
STR DB 9 DUP('$')
NUM DW 0
SUM DW 0
BASE DW 10
BASEH DW 10H
.STACK
.CODE

MAIN PROC FAR
MOV AX, @DATA
MOV DS, AX

;; GETTING THE NUMBER
LEA DX, STRLEN
MOV AH, 0AH
INT 21H

;; CONVERTING TO NUMBER
MOV CX, 00
MOV CL, STRSZ
LEA DI, STR
MOV AX, 00

L1: MOV BL, [DI]
CMP BL, '0'
JB BRK
CMP BL, '9'
JA BRK

;; CONVERTING TO NUMBER
AND BL, 0FH
MUL BASE
ADD AX, BX
INC DI
LOOP L1

BRK: MOV NUM, AX

;; CALCULATING THE SUM
MOV CX, 2
MOV BX, 2

L2: MOV AX, CX
MUL AX
MUL BX
ADD SUM, AX
CMP CX, NUM
INC CX
JBE L2

;; NEW LINE CHARACTER
MOV AH, 02H
MOV DL, 0AH
INT 21H

;; DISPLAYING IN HEX
MOV AX, SUM
MOV CX, 4

L4:  XOR DX, DX
MUL BASEH
MOV BX, AX
CMP DX, 10
JAE ALPHA
OR DL, 30H
JMP DISP

ALPHA:  ADD DL, 55
DISP:  MOV AH, 02H
INT 21H
MOV AX, BX
LOOP L4

;; CONVERTING TO DECIMAL
MOV AX, SUM
MOV CX, 00
MOV BX, 10

L3: MOV DX, 00
INC CX
DIV BX
CMP AX, 00
PUSH DX
JG L3

;; NEW LINE CHARACTER
MOV AH, 02H
MOV DL, 0AH
INT 21H

;; PRINTING IN DECIMAL
DIS: POP DX
OR DX, 30H
MOV AH, 02H
INT 21H
LOOP DIS

;; ENDING PROGRAM
MOV AH, 4CH
INT 21H
MAIN ENDP

END MAIN
