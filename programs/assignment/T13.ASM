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
    NEW DB 0DH, 0AH, '$'
    VOWEL DW 0

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
        JE UPPER
        CMP STRING[BX], 'e'
        JE UPPER
        CMP STRING[BX], 'i'
        JE UPPER
        CMP STRING[BX], 'o'
        JE UPPER
        CMP STRING[BX], 'u'
        JE UPPER
        CMP STRING[BX], 'A'
        JE UPPER
        CMP STRING[BX], 'E'
        JE UPPER
        CMP STRING[BX], 'I'
        JE UPPER
        CMP STRING[BX], 'O'
        JE UPPER
        CMP STRING[BX], 'U'
        JE UPPER

        JNE SKIP

        UPPER:
        INC VOWEL

        SKIP:
        INC BX
    LOOP LP1

    MOV DX, OFFSET NEW
    MOV AH, 09H
    INT 21H

    MOV AX, VOWEL
    CALL DISP_DEC

    MOV AX, 4C00H
    INT 21H

MAIN ENDP

DISP_DEC PROC
XOR CX,CX
OLL:
XOR DX,DX
LL1:
CMP AX,  10D
JB LLESS
SUB AX, 10D
INC DX
JMP LL1

LLESS:
PUSH AX
MOV AX, DX
INC CX
CMP AX, 00H
JNE OLL

LL2:
    POP DX
    ADD DX, 30H
    MOV AH, 02H
    INT 21H
    LOOP LL2
MOV DL, ' '
MOV AH, 02H
INT 21H
RET
DISP_DEC ENDP

END MAIN