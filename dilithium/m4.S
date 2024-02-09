.syntax unified

.global mulmod
.type mulmod,%function
.align 2
mulmod:
    push {r4-r11, r14}

	// TODO: write your code here
	smull r2, r3, r0, r1 // c = a*b
	movw r4, 0xdfff // qinv
	movt r4, 0xfc7f
	mul r5, r2, r4 // t = c * qinv
	movw r6, 0xe001
	movt r6, 0x7f
	smlal r2, r3, r5, r6
	mov r0, r3

    pop {r4-r11, pc}

.global butterfly
.type butterfly,%function
.align 2
butterfly:
    push {r4-r11, r14}

	// TODO: write your code here
	ldr r4, [r0] //r2: a0
	mov r10, r0  // r10: addr of a
	ldr r0, [r0, #4] //r0: a1
	bl mulmod  // r0: mulmod(a1, tw)
	sub r3, r4, r0
	add r2, r4, r0
	str r2, [r10]
	str r3, [r10, #4]

    pop {r4-r11, pc}


.global nttlayer1
.type nttlayer1,%function
.align 2
nttlayer1:
    push {r4-r11, r14}

	// TODO: write your code here
	mov r4, r0
	mov r5, #0
	mov r1, 0x64f7
forloop:
	ldr r6, [r4]
	add r7, r4, #512
	ldr r0, [r7]
	bl mulmod
	add r2, r6, r0 // a0 = a0 + a1 * tw
	sub r3, r6, r0 // a1 = a0 - a1 * tw
	str r2, [r4]
	str r3, [r7]
	add r4, #4
	add r5, #1
	cmp r5, #128
	bne forloop
	

    pop {r4-r11, pc}

.global ntt
.type ntt,%function
.align 2
ntt:
    push {r4-r11, r14}

	// TODO: write your code here
	mov r4, #0 // k = 0
	mov r5, #128 // len = 128
	ldr r7, =twiddles_asm // r7: start address of zetas
	mov r8, r0 // r8: start address of a
loop0:
	mov r6, #0 // start = 0
loop1:	
	ldr r1, [r7]
	mov r9, r6 // j = start
	add r6, r6, r5 //r9: start + len
loop2:
	add r11, r8, r9, lsl #2 // r11 =  a[j(*4bytes)]
	ldr r0, [r11, r5, lsl #2] // r0: a[j+len]
	bl mulmod
	ldr r10, [r11] // r10: a[j]
	add r3, r10, r0
	sub r2, r10, r0
	str r3, [r11]
	str r2, [r11, r5, lsl #2]
	add r9, r9, #1 //++j
	cmp r9, r6 // j < start + len
	bne loop2  //end loop2

	add r6, r6, r5 // start = j + len = start + len + len
	add r7, #4 // zetas[k++]
	cmp r6, #256 // start < 256
	bne loop1 // end loop1

	asr r5, r5, #1 // len >>= 1
	cmp r5, #0
	bne loop0
	
    pop {r4-r11, pc}
