TITLE	HW2 �r�����M�j�p�g����
STACK	  SEGMENT	PARA	STACK	'Stack'
	DB	64 DUP(0)
STACK	  ENDS
;---------------------------------------------------
DATASEG   SEGMENT	PARA	'Data'
HEADNG1	  DB	  'Computer Science 36'
HEADNG2	  DB	  19 DUP ('a'), '$'
DATASEG	  ENDS
;---------------------------------------------------
CODESEG	  SEGMENT	PARA	'Code'
MAIN	PROC 	  FAR
	MOV	  AX, DATASEG	;���X .data ��segment�A�s�J AX
	MOV	  DS,AX		;
	
	
	MOV	  CX,19		;CX ��19 �� chars
	LEA	  SI,HEADNG1	;SI=HEADNG1��offset 
	LEA	  DI,HEADNG2	;DI=HEADNG2��offset
A10:
	MOV	  AL,[SI]	;AL ���o [SI](HEADNG1)��char�A��AL�s�n�ഫ��char
	MOV	  [DI+18],AL	;����r�� ��[DI+18](�̫�@��) ��Computer Science 36�Ĥ@��C
	INC	  SI		;INC�N��:SI++�A�U�@�ӡASI=Computer Science 36��o
	DEC	  DI		;DEC�N��:DI--�A���L�ܦ�[DI-1+18](�˼ƲĤG��)
	DEC	  CX		;DEC�N��:CX--�ACX=19-1=18(��18�Ӧr���n�ഫ)	
	JNZ	  A10		;JNZ�N��:�Ycount������0�h���� A10�A���Ƶ{��
	MOV	  CX,19	
	
A20:			
	MOV	  AH,[SI]	;��SI(HEADNG2)���Ĥ@�Ӧr��
	CMP	  AH,41H	;�P�_�r���O�_���^��r�� �j�g:41H~5AH  �p�g:61H~7AH
	JB 	  A40		;�YAH<41H�h����A40
	CMP	  AH,7AH	;
	JA	  A40		;�YAH>7AH�h����A40
	CMP	  AH,5AH	;
	JBE 	  A30		;�YAH<=5AH�h����A30(�j�g��p�g)
	CMP	  AH,61H	;
	JA	  A30		;�YAH>=61H�h����A30(�p�g��j�g)
	
	CMP	  AH,5AH	;
	JA 	  A40		;�YAH>5AH�h����A40(�j�g�p�g�����r����������)

A30:
	XOR	  AH,00100000B  ;����j�p�g����(byte�ĤT��0��1�A1��0)
	MOV	  [SI],AH	;�N�������r���s�^SI(HEADNG2)

A40:
	INC	  SI		;BX(HEADNG2)++ �~�򰵤U�@�Ӧr��
	LOOP	  A20		;�j��A�`�@�|����CX(19)�� 

	MOV	  AH,09H	;��X�r���ù��A���n��ܪ��r�ꥲ���H�u$�v����
	LEA	  DX,HEADNG2	;�qHEADNG2�}�l��ܦr��
	INT	  21H		;INT�N��:�I�s���_�Ƶ{��

	MOV	  AX,4C00H	;�����{��
	INT	  21H 		;INT�N��:�I�s���_�Ƶ{��
MAIN	ENDP
CODESEG	ENDS
	END	  MAIN
