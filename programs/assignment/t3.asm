.MODEL SMALL
.STACK 64

.DATA
    M_ROW DB 0
    M_COL DB 0 
    VAL DB 2
    INP DB "ENTER A STRING: $"
    MAXC DB 100
    ACTC DB ?
    STRING DB 101 DUP('$')

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    
    MOV DX, OFFSET INP
    MOV AH, 09H
    INT 21H

    MOV DX, OFFSET MAXC
    MOV AH, 0AH 
    INT 21H

    MOV AX, 0003H
    INT 10H
    ; GET MIDDLE ROW
    MOV AX, 1130h     ; Function to get font information
    MOV BH, 06h       ; Request to get the number of rows
    INT 10h           ; Call BIOS interrupt
    MOV M_ROW, DL
    INC M_ROW           ; 0 -24 MEANS 25 ROWS
    XOR AX, AX
    MOV AL, M_ROW
    DIV VAL
    MOV M_ROW, AL

    ;GET MIDDLE COLUMN
    XOR AX, AX
    MOV AH, 0FH
    INT 10H 
    MOV M_COL, AH 
    XOR AX, AX
    MOV AL, M_COL
    DIV VAL
    MOV M_COL, AL

    XOR AX, AX 
    MOV AL, ACTC
    DIV VAL
    SUB M_COL, AL

    MOV BH, 00H 
    MOV DH, M_ROW
    MOV DL, M_COL 
    MOV AH, 02H
    INT 10H

    MOV DX, OFFSET STRING
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H

MAIN ENDP

DISP_DEC PROC
	XOR CX,CX
OL:
	XOR DX,DX
L1:
	CMP AX,  10D
JB LESS
	SUB AX, 10D
	INC DX
JMP L1

LESS:
	PUSH AX
	MOV AX, DX
	INC CX
	CMP AX, 00H
JNE OL

L2:
    POP DX
    ADD DX, 30H
    MOV AH, 02H
    INT 21H
    LOOP L2

RET
DISP_DEC ENDP

END MAIN
