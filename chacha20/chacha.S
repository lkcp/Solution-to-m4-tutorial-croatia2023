.syntax unified

// quarterround(uint32 *a, uint32 *b, uint32 *c, uint32 *d)
.global quarterround
.type quarterround,%function
.align 2
quarterround:
	push {r4-r11, r14}

	ldr r4, [r0] // a
	ldr r5, [r1] // b
	ldr r6, [r2] // c
	ldr r7, [r3] // d

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 16)
	mov r8, r7, lsr #16
	eor r7, r8, r7, lsl #16

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 12)
	mov r8, r5, lsr #20
	eor r5, r8, r5, lsl #12

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 8)
	mov r8, r7, lsr #24
	eor r7, r8, r7, lsl #8

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 7)
	mov r8, r5, lsr #25
	eor r5, r8, r5, lsl #7

	str r4, [r0]
	str r5, [r1]
	str r6, [r2]
	str r7, [r3]
	
	pop {r4-r11, pc}
	.size quarterround, .-quarterround

.global quarterround16
.type quarterround16, %function
.align 2
quarterround16:
	push {r4-r11, r14}

	// the first group
	ldr r4, [r0] // a
	ldr r5, [r1] // b
	ldr r6, [r2] // c
	ldr r7, [r3] // d

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 16)
	mov r8, r7, lsr #16
	eor r7, r8, r7, lsl #16

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 12)
	mov r8, r5, lsr #20
	eor r5, r8, r5, lsl #12

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 8)
	mov r8, r7, lsr #24
	eor r7, r8, r7, lsl #8

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 7)
	mov r8, r5, lsr #25
	eor r5, r8, r5, lsl #7

	str r4, [r0]
	str r5, [r1]
	str r6, [r2]
	str r7, [r3]

	// the second group
	ldr r0, [sp, #36]
	ldr r1, [sp, #40]
	ldr r2, [sp, #44]
	ldr r3, [sp, #48]
	
	ldr r4, [r0] // a
	ldr r5, [r1] // b
	ldr r6, [r2] // c
	ldr r7, [r3] // d

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 16)
	mov r8, r7, lsr #16
	eor r7, r8, r7, lsl #16

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 12)
	mov r8, r5, lsr #20
	eor r5, r8, r5, lsl #12

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 8)
	mov r8, r7, lsr #24
	eor r7, r8, r7, lsl #8

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 7)
	mov r8, r5, lsr #25
	eor r5, r8, r5, lsl #7

	str r4, [r0]
	str r5, [r1]
	str r6, [r2]
	str r7, [r3]
	
	// the third group
	ldr r0, [sp, #52]
	ldr r1, [sp, #56]
	ldr r2, [sp, #60]
	ldr r3, [sp, #64]
	
	ldr r4, [r0] // a
	ldr r5, [r1] // b
	ldr r6, [r2] // c
	ldr r7, [r3] // d

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 16)
	mov r8, r7, lsr #16
	eor r7, r8, r7, lsl #16

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 12)
	mov r8, r5, lsr #20
	eor r5, r8, r5, lsl #12

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 8)
	mov r8, r7, lsr #24
	eor r7, r8, r7, lsl #8

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 7)
	mov r8, r5, lsr #25
	eor r5, r8, r5, lsl #7

	str r4, [r0]
	str r5, [r1]
	str r6, [r2]
	str r7, [r3]
	
	// the fourth group
	ldr r0, [sp, #68]
	ldr r1, [sp, #72]
	ldr r2, [sp, #76]
	ldr r3, [sp, #80]
	
	ldr r4, [r0] // a
	ldr r5, [r1] // b
	ldr r6, [r2] // c
	ldr r7, [r3] // d

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 16)
	mov r8, r7, lsr #16
	eor r7, r8, r7, lsl #16

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 12)
	mov r8, r5, lsr #20
	eor r5, r8, r5, lsl #12

	add r4, r4, r5 // a = a + b
	eor r7, r7, r4 // d = d ^ a

	// d = rotate(d, 8)
	mov r8, r7, lsr #24
	eor r7, r8, r7, lsl #8

	add r6, r6, r7 // c = c + d
	eor r5, r5, r6 // b = b ^ c

	// b = rotate(b, 7)
	mov r8, r5, lsr #25
	eor r5, r8, r5, lsl #7

	str r4, [r0]
	str r5, [r1]
	str r6, [r2]
	str r7, [r3]
	
	pop {r4-r11, pc}
	// add sp, sp, #48
	.size quarterround16, .-quarterround16
