;K(05.12.2014.)
;U memoriji su date dvije 16b vrijednosti na lokacijama X i Y. Napisati asemblerski program koji odredjuje
;koji od dva podatka ima manje pozitivnih djelilaca. Broj djelilaca za taj podatak je potrebno smijestiti na
;lokaciju NUM. Nije dozvoljeno mijenjati sadrzaj X i Y. 


SECTION .data
X	dw	4	;assume that numbers are positive!We'll treat them as an unsigned!
Y	dw	12
NUM	db	0

SECTION .text
global _start
_start:

MOV 	ESI,X
MOV	CX,[X]

iterate:
    MOV 	BL,0	;current number of factors

count_down:
	MOV	DX,0
	MOV 	AX,[ESI]
	DIV	CX
	CMP	DX,0
	JZ	increment
	DEC	CX
	JNZ	count_down

      increment:
	      INC	BL
	      CMP	BL,[NUM]	
	      JA	do_set	
	      
      continue:
	      LOOP	count_down
	      CMP	ESI,Y
	      JE end
MOV	ESI,Y
MOV	CX,[Y]
JMP	iterate  

do_set:
		MOV	[NUM],BL
		JMP	continue

end:
MOV	DL,[NUM]	;just to check value

MOV EAX,1
MOV EBX,0
INT 80h