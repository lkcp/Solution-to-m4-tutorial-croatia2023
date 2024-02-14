.syntax unified

.global mulmod
.type mulmod,%function
.align 2
mulmod:
    push {r4-r11, r14}

	// TODO: write your code here
	smulwb r4, r1, r0
	mov r5, 0xd01
	mov r6, 0x6808
	smlabb r4, r4, r5, r6
	mov r0, r4, asr #16
	
    pop {r4-r11, pc}

.global butterfly
.type butterfly,%function
.align 2
butterfly:
    push {r4-r11, r14}

	// TODO: write your code here
	ldrh r4, [r0] //r2: a0
	mov r10, r0  // r10: addr of a
	ldrh r0, [r0, #2] //r0: a1
	bl mulmod  // r0: mulmod(a1, tw)
	sub r3, r4, r0
	add r2, r4, r0
	strh r2, [r10]
	strh r3, [r10, #2]

    pop {r4-r11, pc}


.global nttlayer1
.type nttlayer1,%function
.align 2
nttlayer1:
    push {r4-r11, r14}

	// TODO: write your code here
	mov r4, r0
	mov r5, #0
	movw r1, 0xc5b6
	movt r1, 0x84f5
forloop:
	ldrh r6, [r4]
	add r7, r4, #256
	ldrh r0, [r7]
	bl mulmod
	add r2, r6, r0 // a0 = a0 + a1 * tw
	sub r3, r6, r0 // a1 = a0 - a1 * tw
	strh r2, [r4]
	strh r3, [r7]
	add r4, #2
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
	add r11, r8, r9, lsl #1 // r11 =  a[j(*2bytes)]
	ldrh r0, [r11, r5, lsl #1] // r0: a[j+len]
	bl mulmod
	ldrh r10, [r11] // r10: a[j]
	add r3, r10, r0
	sub r2, r10, r0
	strh r3, [r11]
	strh r2, [r11, r5, lsl #1]
	add r9, r9, #1 //++j
	cmp r9, r6 // j < start + len
	bne loop2  //end loop2

	add r6, r6, r5 // start = j + len = start + len + len
	add r7, #4 // zetas[k++]
	cmp r6, #256 // start < 256
	bne loop1 // end loop1

	asr r5, r5, #1 // len >>= 1
	cmp r5, #1
	bne loop0

    pop {r4-r11, pc}
