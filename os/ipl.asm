CYLS EQU 10

ORG 0x7c00

        JMP entry
        DB 0x90
        DB "RIHITO  "
        DW 512
        DB 1
        DW 1
        DB 2
        DW 224
        DW 2880
        DB 0xf0
        DW 9
        DW 18
        DW 2
        DD 0
        DD 2880

        DB 0x00
        DB 0x00
        DB 0x29

        DD 0xffffffff
        DB "RIHITO-OS"
        DB "FAT12   "
        RESB 18

;intialize
entry:
        MOV AX,0        ;intialize AX register
        MOV SS,AX
        MOV SP,0x7c00
        MOV DS,AX

;load disk
        MOV AX,0x0820
        MOV ES,AX
        MOV CH,0        ;cliynder 0
        MOV DH,0        ;head 0
        MOV CL,2        ;sector 2
readloop:
        MOV SI,0          ;Number of failures SI++
retry:
        MOV AH,0x02     ;read disk 0x02
        MOV AL,1        ;sector 1
        MOV BX,0

        MOV DL,0x00     ;A drive
        INT 0x13        ;Call the bios
        JNC next        ;If no error occurred,jamp next

        ADD SI,1          ;SI++
        CMP SI,5        ;If SI >= 5,jamp to error
        JAE error

        MOV AH,0x00
        MOV DL,0x00     ;A drive
        INT 0x13        ;Reset drive
        JMP retry       ;jamp to retry
next:
        MOV AX,ES
        ADD AX,0x0020
        MOV ES,AX

        ADD CL,1          ;clinder++
        CMP CL,18       ;If CH <= CYLS,jamp to readloop
        JBE readloop

        MOV CL,1
        ADD DH,1
        CMP DH,2        ;If DH < 2,jamp to readloop
        JB readloop

        MOV DH,0
        ADD CH,1        ;clinder++
        CMP CH,CYLS
        JB readloop

        ;Run main OS
        MOV [0x0ff0],CH
        JMP 0xc200
error:
        MOV SI,msg
putloop:
        MOV AL,[SI]
        ADD SI,1        ;SI++
        CMP AL,0        ;If AL == 0,jamp to fin
        JE fin
        
        MOV AH,0x0e     ;1 char function
        MOV BX,15       ;color code
        INT 0x10
        JMP putloop
fin:
        HLT
        JMP fin
msg:                    ;error message
        DB 0x0a,0x0a
        DB "load error"
        DB 0x0a
        DB 0

RESB    0x7dfe - 0x7c00 - ($ - $$)
DB 0x55,0xaa
