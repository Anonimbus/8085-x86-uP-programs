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
    NEW DB 0D, 0AH, '$'

    TWO DB 02H

    TOP DB 3D
    LEFT DB 10D   
    BOTTOM DB 21D 
    RIGHT DB 70D

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

    XOR CX, CX
    XOR BX, BX
    MOV CL, ACTC

    LP1:
        MOV AL, STRING[BX]
        CMP STRING[BX], 'A'
        JB SKIP
        CMP STRING[BX], 'Z'
        JA SKIP

        ADD STRING[BX], 20H

        SKIP:
        INC BX
    LOOP LP1

    MOV AX, 0003H
    INT 10H

    MOV CH, TOP
    MOV CL, LEFT  
    MOV DH, BOTTOM
    MOV DL, RIGHT
    MOV AX, 0600H
    MOV BH, 30H
    INT 10H
  
    MOV DH, BOTTOM
    MOV DL, LEFT
    MOV AH, 02H
    MOV AL, 00H
    MOV BH, 00H
    INT 10H

    MOV DX, OFFSET STRING
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN