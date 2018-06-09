;convert

.286
 CSEG segment

assume CS:CSEG, DS:CSEG, ES:CSEG, SS:CSEG

 org 100h
start:
jmp start2

error db "error write mbr ",13,10,'$'
error2 db "error read file",13,10,'$'
ok db "ok",13,10,'$'
file db 'writembr.sec',0

start1:
mov edx,TIMES
     start:
		mov ecx,lengthOfArray
		mov esi,dword ptr x
		shr ecx,5 //shr ecx,2
		 			 
        mov edi, dword ptr y
		//mov ebx,16
	label:
	//	prefetchnta [esi+0x10] 
		movdqa xmm0,  [esi]
			movdqa xmm1,  [esi+16]
				movdqa xmm2,  [esi+32]
					movdqa xmm3,  [esi+48]

						movdqa xmm4,  [esi+64]
						movdqa xmm5,  [esi+64+16]
						movdqa xmm6,  [esi+64+32]
						movdqa xmm7,  [esi+64+48]

		//prefetchnta [esi+64] 
		paddd xmm0,  [edi]
			paddd xmm1,  [edi+16]
				paddd xmm2,  [edi+32]
					paddd xmm3,  [edi+48]
						paddd xmm4,  [edi+64]
						paddd xmm5,  [edi+64+16]
						paddd xmm6,  [edi+64+32]
						paddd xmm7,  [edi+64+48]
			 


	
		movdqa  [esi],xmm0
			movdqa  [esi+16],xmm1
				movdqa  [esi+32],xmm2
					movdqa  [esi+48],xmm3
						movdqa  [esi+64],xmm4
						movdqa  [esi+64+16],xmm5
						movdqa  [esi+64+32],xmm6
						movdqa  [esi+64+48],xmm7

			add edi,128//add edi,64//add edi,16
			add esi,128 //add esi,64 	//add esi,16
		dec ecx	
		jnz label
		dec edx
        jnz start


mov ecx,lengthOfArray
		mov esi,  x
		shr ecx,4
        mov edi, y

		movdqa xmm0,  [esi]
		movdqa  [edi],xmm0
		add esi,16
		add edi,16
        dec ecx	

		movdqa xmm0,  [esi]
		movdqa  [edi],xmm0
		add esi,16
		add edi,16
        dec ecx	
		movdqa xmm0,  [esi]
		movdqa  [edi],xmm0
		add esi,16
		add edi,16
        dec ecx	

	label:
		movaps  xmm0,  [esi]
			//movdqa xmm0,  [esi]
		movaps xmm1,  [edi ] 
		//movdqa xmm1,  [edi ]
			//	prefetchnta [esi+0x10] 
			//	paddd xmm0,  xmm1
			//	psrlq xmm0,1
	 	Paddusb xmm0,xmm1 //mix
		//movdqa  [edi],xmm0
		movaps  [edi],xmm0
		add esi,16
		add edi,16
        dec ecx	
		jnz label



;start2:
 mov edi,TIMES
        start:
        mov esi,0
        mov ecx,lengthOfArray
        label:
        mov edx,x
        push edx
        mov eax,DWORD PTR [edx + esi*4]
        mov edx,y
        mov ebx,DWORD PTR [edx + esi*4]
        add eax,ebx
        pop edx
        mov [edx + esi*4],eax
        inc esi
        loop label
        dec edi
        cmp edi,0
        jnz start



 end start
mov ebx,TIMES
     start:
		mov ecx,lengthOfArray
		mov esi,x
		//shr ecx,2
        mov edi,y
	label:
		mov eax,DWORD PTR [esi]
		add eax,DWORD PTR [edi]
		add edi,4	
		dec ecx	
		mov DWORD PTR [esi],eax
		add esi,4
        test ecx,ecx
		jnz label
		dec ebx
		test ebx,ebx
        jnz start
        
        END

EMMS
		mov ebx,TIMES
     start:
		mov ecx,lengthOfArray
		mov esi,x
		shr ecx,1
        mov edi,y
	label:
		movq mm0,QWORD PTR[esi]
		paddd mm0,QWORD PTR[edi]
		add edi,8
		movq QWORD PTR[esi],mm0
		add esi,8
        dec ecx	

		jnz label
		dec ebx
        jnz start
		EMMS

mov ebx,TIMES
     start:
		mov ecx,lengthOfArray
		mov esi,dword ptr x
		shr ecx,2
        mov edi, dword ptr y
	label:
		movdqa xmm0,  [esi]
	//	prefetchnta [esi+0x10] 
		paddd xmm0,  [edi]

		add edi,16
		movdqa  [esi],xmm0
		add esi,16
        dec ecx	
		jnz label
		dec ebx
        jnz start
