.MODEL SMALL
.STACK 64

.DATA
    STRING DB "this is a string with all lowercase letters.$"

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

    XOR BX, BX
    LP1:
        CMP STRING[BX], '$'
        JE EXIT
        CMP STRING[BX], 'a'
        JB SKIP
        CMP STRING[BX], 'z'
        JA SKIP

        SUB STRING[BX], 20H

        SKIP:
        INC BX
    JMP LP1

    EXIT:
    MOV AX, 0003H
    INT 10H

    MOV DX, OFFSET STRING
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN