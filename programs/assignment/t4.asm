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
        CMP STRING[BX], 'a'
        JB SKIP
        CMP STRING[BX], 'z'
        JA SKIP

        SUB STRING[BX], 20H

        SKIP:
        INC BX
    LOOP LP1

    MOV DX, OFFSET NEW
    MOV AH, 09H
    INT 21H

    MOV DX, OFFSET STRING
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN