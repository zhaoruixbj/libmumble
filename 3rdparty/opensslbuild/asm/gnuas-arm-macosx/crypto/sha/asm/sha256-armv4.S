.code	32

.align	5
K256:
.word	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5
.word	0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5
.word	0xd807aa98,0x12835b01,0x243185be,0x550c7dc3
.word	0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174
.word	0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc
.word	0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da
.word	0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7
.word	0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967
.word	0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13
.word	0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85
.word	0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3
.word	0xd192e819,0xd6990624,0xf40e3585,0x106aa070
.word	0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5
.word	0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3
.word	0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208
.word	0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2

.global	_sha256_block_data_order
_sha256_block_data_order:
	sub	r3,pc,#8		@ _sha256_block_data_order
	add	r2,r1,r2,lsl#6	@ len to point at the end of inp
	stmdb	sp!,{r0,r1,r2,r4-r12,lr}
	ldmia	r0,{r4,r5,r6,r7,r8,r9,r10,r11}
	sub	r14,r3,#256		@ K256
	sub	sp,sp,#16*4		@ alloca(X[16])
.Loop:
	ldrb	r3,[r1,#3]			@ 0
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r8,ror#6
	str	r3,[sp,#0*4]
	eor	r0,r0,r8,ror#11
	eor	r2,r9,r10
	eor	r0,r0,r8,ror#25	@ Sigma1(e)
	and	r2,r2,r8
	add	r3,r3,r0
	eor	r2,r2,r10			@ Ch(e,f,g)
	add	r3,r3,r11
	mov	r11,r4,ror#2
	add	r3,r3,r2
	eor	r11,r11,r4,ror#13
	add	r3,r3,r12
	eor	r11,r11,r4,ror#22		@ Sigma0(a)
	orr	r0,r4,r5
	and	r2,r4,r5
	and	r0,r0,r6
	add	r11,r11,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r7,r7,r3
	add	r11,r11,r0
	ldrb	r3,[r1,#3]			@ 1
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r7,ror#6
	str	r3,[sp,#1*4]
	eor	r0,r0,r7,ror#11
	eor	r2,r8,r9
	eor	r0,r0,r7,ror#25	@ Sigma1(e)
	and	r2,r2,r7
	add	r3,r3,r0
	eor	r2,r2,r9			@ Ch(e,f,g)
	add	r3,r3,r10
	mov	r10,r11,ror#2
	add	r3,r3,r2
	eor	r10,r10,r11,ror#13
	add	r3,r3,r12
	eor	r10,r10,r11,ror#22		@ Sigma0(a)
	orr	r0,r11,r4
	and	r2,r11,r4
	and	r0,r0,r5
	add	r10,r10,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r6,r6,r3
	add	r10,r10,r0
	ldrb	r3,[r1,#3]			@ 2
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r6,ror#6
	str	r3,[sp,#2*4]
	eor	r0,r0,r6,ror#11
	eor	r2,r7,r8
	eor	r0,r0,r6,ror#25	@ Sigma1(e)
	and	r2,r2,r6
	add	r3,r3,r0
	eor	r2,r2,r8			@ Ch(e,f,g)
	add	r3,r3,r9
	mov	r9,r10,ror#2
	add	r3,r3,r2
	eor	r9,r9,r10,ror#13
	add	r3,r3,r12
	eor	r9,r9,r10,ror#22		@ Sigma0(a)
	orr	r0,r10,r11
	and	r2,r10,r11
	and	r0,r0,r4
	add	r9,r9,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r5,r5,r3
	add	r9,r9,r0
	ldrb	r3,[r1,#3]			@ 3
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r5,ror#6
	str	r3,[sp,#3*4]
	eor	r0,r0,r5,ror#11
	eor	r2,r6,r7
	eor	r0,r0,r5,ror#25	@ Sigma1(e)
	and	r2,r2,r5
	add	r3,r3,r0
	eor	r2,r2,r7			@ Ch(e,f,g)
	add	r3,r3,r8
	mov	r8,r9,ror#2
	add	r3,r3,r2
	eor	r8,r8,r9,ror#13
	add	r3,r3,r12
	eor	r8,r8,r9,ror#22		@ Sigma0(a)
	orr	r0,r9,r10
	and	r2,r9,r10
	and	r0,r0,r11
	add	r8,r8,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r4,r4,r3
	add	r8,r8,r0
	ldrb	r3,[r1,#3]			@ 4
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r4,ror#6
	str	r3,[sp,#4*4]
	eor	r0,r0,r4,ror#11
	eor	r2,r5,r6
	eor	r0,r0,r4,ror#25	@ Sigma1(e)
	and	r2,r2,r4
	add	r3,r3,r0
	eor	r2,r2,r6			@ Ch(e,f,g)
	add	r3,r3,r7
	mov	r7,r8,ror#2
	add	r3,r3,r2
	eor	r7,r7,r8,ror#13
	add	r3,r3,r12
	eor	r7,r7,r8,ror#22		@ Sigma0(a)
	orr	r0,r8,r9
	and	r2,r8,r9
	and	r0,r0,r10
	add	r7,r7,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r11,r11,r3
	add	r7,r7,r0
	ldrb	r3,[r1,#3]			@ 5
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r11,ror#6
	str	r3,[sp,#5*4]
	eor	r0,r0,r11,ror#11
	eor	r2,r4,r5
	eor	r0,r0,r11,ror#25	@ Sigma1(e)
	and	r2,r2,r11
	add	r3,r3,r0
	eor	r2,r2,r5			@ Ch(e,f,g)
	add	r3,r3,r6
	mov	r6,r7,ror#2
	add	r3,r3,r2
	eor	r6,r6,r7,ror#13
	add	r3,r3,r12
	eor	r6,r6,r7,ror#22		@ Sigma0(a)
	orr	r0,r7,r8
	and	r2,r7,r8
	and	r0,r0,r9
	add	r6,r6,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r10,r10,r3
	add	r6,r6,r0
	ldrb	r3,[r1,#3]			@ 6
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r10,ror#6
	str	r3,[sp,#6*4]
	eor	r0,r0,r10,ror#11
	eor	r2,r11,r4
	eor	r0,r0,r10,ror#25	@ Sigma1(e)
	and	r2,r2,r10
	add	r3,r3,r0
	eor	r2,r2,r4			@ Ch(e,f,g)
	add	r3,r3,r5
	mov	r5,r6,ror#2
	add	r3,r3,r2
	eor	r5,r5,r6,ror#13
	add	r3,r3,r12
	eor	r5,r5,r6,ror#22		@ Sigma0(a)
	orr	r0,r6,r7
	and	r2,r6,r7
	and	r0,r0,r8
	add	r5,r5,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r9,r9,r3
	add	r5,r5,r0
	ldrb	r3,[r1,#3]			@ 7
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r9,ror#6
	str	r3,[sp,#7*4]
	eor	r0,r0,r9,ror#11
	eor	r2,r10,r11
	eor	r0,r0,r9,ror#25	@ Sigma1(e)
	and	r2,r2,r9
	add	r3,r3,r0
	eor	r2,r2,r11			@ Ch(e,f,g)
	add	r3,r3,r4
	mov	r4,r5,ror#2
	add	r3,r3,r2
	eor	r4,r4,r5,ror#13
	add	r3,r3,r12
	eor	r4,r4,r5,ror#22		@ Sigma0(a)
	orr	r0,r5,r6
	and	r2,r5,r6
	and	r0,r0,r7
	add	r4,r4,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r8,r8,r3
	add	r4,r4,r0
	ldrb	r3,[r1,#3]			@ 8
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r8,ror#6
	str	r3,[sp,#8*4]
	eor	r0,r0,r8,ror#11
	eor	r2,r9,r10
	eor	r0,r0,r8,ror#25	@ Sigma1(e)
	and	r2,r2,r8
	add	r3,r3,r0
	eor	r2,r2,r10			@ Ch(e,f,g)
	add	r3,r3,r11
	mov	r11,r4,ror#2
	add	r3,r3,r2
	eor	r11,r11,r4,ror#13
	add	r3,r3,r12
	eor	r11,r11,r4,ror#22		@ Sigma0(a)
	orr	r0,r4,r5
	and	r2,r4,r5
	and	r0,r0,r6
	add	r11,r11,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r7,r7,r3
	add	r11,r11,r0
	ldrb	r3,[r1,#3]			@ 9
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r7,ror#6
	str	r3,[sp,#9*4]
	eor	r0,r0,r7,ror#11
	eor	r2,r8,r9
	eor	r0,r0,r7,ror#25	@ Sigma1(e)
	and	r2,r2,r7
	add	r3,r3,r0
	eor	r2,r2,r9			@ Ch(e,f,g)
	add	r3,r3,r10
	mov	r10,r11,ror#2
	add	r3,r3,r2
	eor	r10,r10,r11,ror#13
	add	r3,r3,r12
	eor	r10,r10,r11,ror#22		@ Sigma0(a)
	orr	r0,r11,r4
	and	r2,r11,r4
	and	r0,r0,r5
	add	r10,r10,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r6,r6,r3
	add	r10,r10,r0
	ldrb	r3,[r1,#3]			@ 10
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r6,ror#6
	str	r3,[sp,#10*4]
	eor	r0,r0,r6,ror#11
	eor	r2,r7,r8
	eor	r0,r0,r6,ror#25	@ Sigma1(e)
	and	r2,r2,r6
	add	r3,r3,r0
	eor	r2,r2,r8			@ Ch(e,f,g)
	add	r3,r3,r9
	mov	r9,r10,ror#2
	add	r3,r3,r2
	eor	r9,r9,r10,ror#13
	add	r3,r3,r12
	eor	r9,r9,r10,ror#22		@ Sigma0(a)
	orr	r0,r10,r11
	and	r2,r10,r11
	and	r0,r0,r4
	add	r9,r9,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r5,r5,r3
	add	r9,r9,r0
	ldrb	r3,[r1,#3]			@ 11
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r5,ror#6
	str	r3,[sp,#11*4]
	eor	r0,r0,r5,ror#11
	eor	r2,r6,r7
	eor	r0,r0,r5,ror#25	@ Sigma1(e)
	and	r2,r2,r5
	add	r3,r3,r0
	eor	r2,r2,r7			@ Ch(e,f,g)
	add	r3,r3,r8
	mov	r8,r9,ror#2
	add	r3,r3,r2
	eor	r8,r8,r9,ror#13
	add	r3,r3,r12
	eor	r8,r8,r9,ror#22		@ Sigma0(a)
	orr	r0,r9,r10
	and	r2,r9,r10
	and	r0,r0,r11
	add	r8,r8,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r4,r4,r3
	add	r8,r8,r0
	ldrb	r3,[r1,#3]			@ 12
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r4,ror#6
	str	r3,[sp,#12*4]
	eor	r0,r0,r4,ror#11
	eor	r2,r5,r6
	eor	r0,r0,r4,ror#25	@ Sigma1(e)
	and	r2,r2,r4
	add	r3,r3,r0
	eor	r2,r2,r6			@ Ch(e,f,g)
	add	r3,r3,r7
	mov	r7,r8,ror#2
	add	r3,r3,r2
	eor	r7,r7,r8,ror#13
	add	r3,r3,r12
	eor	r7,r7,r8,ror#22		@ Sigma0(a)
	orr	r0,r8,r9
	and	r2,r8,r9
	and	r0,r0,r10
	add	r7,r7,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r11,r11,r3
	add	r7,r7,r0
	ldrb	r3,[r1,#3]			@ 13
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r11,ror#6
	str	r3,[sp,#13*4]
	eor	r0,r0,r11,ror#11
	eor	r2,r4,r5
	eor	r0,r0,r11,ror#25	@ Sigma1(e)
	and	r2,r2,r11
	add	r3,r3,r0
	eor	r2,r2,r5			@ Ch(e,f,g)
	add	r3,r3,r6
	mov	r6,r7,ror#2
	add	r3,r3,r2
	eor	r6,r6,r7,ror#13
	add	r3,r3,r12
	eor	r6,r6,r7,ror#22		@ Sigma0(a)
	orr	r0,r7,r8
	and	r2,r7,r8
	and	r0,r0,r9
	add	r6,r6,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r10,r10,r3
	add	r6,r6,r0
	ldrb	r3,[r1,#3]			@ 14
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r10,ror#6
	str	r3,[sp,#14*4]
	eor	r0,r0,r10,ror#11
	eor	r2,r11,r4
	eor	r0,r0,r10,ror#25	@ Sigma1(e)
	and	r2,r2,r10
	add	r3,r3,r0
	eor	r2,r2,r4			@ Ch(e,f,g)
	add	r3,r3,r5
	mov	r5,r6,ror#2
	add	r3,r3,r2
	eor	r5,r5,r6,ror#13
	add	r3,r3,r12
	eor	r5,r5,r6,ror#22		@ Sigma0(a)
	orr	r0,r6,r7
	and	r2,r6,r7
	and	r0,r0,r8
	add	r5,r5,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r9,r9,r3
	add	r5,r5,r0
	ldrb	r3,[r1,#3]			@ 15
	ldrb	r12,[r1,#2]
	ldrb	r2,[r1,#1]
	ldrb	r0,[r1],#4
	orr	r3,r3,r12,lsl#8
	orr	r3,r3,r2,lsl#16
	orr	r3,r3,r0,lsl#24
	str	r1,[sp,#17*4]
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r9,ror#6
	str	r3,[sp,#15*4]
	eor	r0,r0,r9,ror#11
	eor	r2,r10,r11
	eor	r0,r0,r9,ror#25	@ Sigma1(e)
	and	r2,r2,r9
	add	r3,r3,r0
	eor	r2,r2,r11			@ Ch(e,f,g)
	add	r3,r3,r4
	mov	r4,r5,ror#2
	add	r3,r3,r2
	eor	r4,r4,r5,ror#13
	add	r3,r3,r12
	eor	r4,r4,r5,ror#22		@ Sigma0(a)
	orr	r0,r5,r6
	and	r2,r5,r6
	and	r0,r0,r7
	add	r4,r4,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r8,r8,r3
	add	r4,r4,r0
.Lrounds_16_xx:
	ldr	r2,[sp,#1*4]		@ 16
	ldr	r12,[sp,#14*4]
	ldr	r3,[sp,#0*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#9*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r8,ror#6
	str	r3,[sp,#0*4]
	eor	r0,r0,r8,ror#11
	eor	r2,r9,r10
	eor	r0,r0,r8,ror#25	@ Sigma1(e)
	and	r2,r2,r8
	add	r3,r3,r0
	eor	r2,r2,r10			@ Ch(e,f,g)
	add	r3,r3,r11
	mov	r11,r4,ror#2
	add	r3,r3,r2
	eor	r11,r11,r4,ror#13
	add	r3,r3,r12
	eor	r11,r11,r4,ror#22		@ Sigma0(a)
	orr	r0,r4,r5
	and	r2,r4,r5
	and	r0,r0,r6
	add	r11,r11,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r7,r7,r3
	add	r11,r11,r0
	ldr	r2,[sp,#2*4]		@ 17
	ldr	r12,[sp,#15*4]
	ldr	r3,[sp,#1*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#10*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r7,ror#6
	str	r3,[sp,#1*4]
	eor	r0,r0,r7,ror#11
	eor	r2,r8,r9
	eor	r0,r0,r7,ror#25	@ Sigma1(e)
	and	r2,r2,r7
	add	r3,r3,r0
	eor	r2,r2,r9			@ Ch(e,f,g)
	add	r3,r3,r10
	mov	r10,r11,ror#2
	add	r3,r3,r2
	eor	r10,r10,r11,ror#13
	add	r3,r3,r12
	eor	r10,r10,r11,ror#22		@ Sigma0(a)
	orr	r0,r11,r4
	and	r2,r11,r4
	and	r0,r0,r5
	add	r10,r10,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r6,r6,r3
	add	r10,r10,r0
	ldr	r2,[sp,#3*4]		@ 18
	ldr	r12,[sp,#0*4]
	ldr	r3,[sp,#2*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#11*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r6,ror#6
	str	r3,[sp,#2*4]
	eor	r0,r0,r6,ror#11
	eor	r2,r7,r8
	eor	r0,r0,r6,ror#25	@ Sigma1(e)
	and	r2,r2,r6
	add	r3,r3,r0
	eor	r2,r2,r8			@ Ch(e,f,g)
	add	r3,r3,r9
	mov	r9,r10,ror#2
	add	r3,r3,r2
	eor	r9,r9,r10,ror#13
	add	r3,r3,r12
	eor	r9,r9,r10,ror#22		@ Sigma0(a)
	orr	r0,r10,r11
	and	r2,r10,r11
	and	r0,r0,r4
	add	r9,r9,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r5,r5,r3
	add	r9,r9,r0
	ldr	r2,[sp,#4*4]		@ 19
	ldr	r12,[sp,#1*4]
	ldr	r3,[sp,#3*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#12*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r5,ror#6
	str	r3,[sp,#3*4]
	eor	r0,r0,r5,ror#11
	eor	r2,r6,r7
	eor	r0,r0,r5,ror#25	@ Sigma1(e)
	and	r2,r2,r5
	add	r3,r3,r0
	eor	r2,r2,r7			@ Ch(e,f,g)
	add	r3,r3,r8
	mov	r8,r9,ror#2
	add	r3,r3,r2
	eor	r8,r8,r9,ror#13
	add	r3,r3,r12
	eor	r8,r8,r9,ror#22		@ Sigma0(a)
	orr	r0,r9,r10
	and	r2,r9,r10
	and	r0,r0,r11
	add	r8,r8,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r4,r4,r3
	add	r8,r8,r0
	ldr	r2,[sp,#5*4]		@ 20
	ldr	r12,[sp,#2*4]
	ldr	r3,[sp,#4*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#13*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r4,ror#6
	str	r3,[sp,#4*4]
	eor	r0,r0,r4,ror#11
	eor	r2,r5,r6
	eor	r0,r0,r4,ror#25	@ Sigma1(e)
	and	r2,r2,r4
	add	r3,r3,r0
	eor	r2,r2,r6			@ Ch(e,f,g)
	add	r3,r3,r7
	mov	r7,r8,ror#2
	add	r3,r3,r2
	eor	r7,r7,r8,ror#13
	add	r3,r3,r12
	eor	r7,r7,r8,ror#22		@ Sigma0(a)
	orr	r0,r8,r9
	and	r2,r8,r9
	and	r0,r0,r10
	add	r7,r7,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r11,r11,r3
	add	r7,r7,r0
	ldr	r2,[sp,#6*4]		@ 21
	ldr	r12,[sp,#3*4]
	ldr	r3,[sp,#5*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#14*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r11,ror#6
	str	r3,[sp,#5*4]
	eor	r0,r0,r11,ror#11
	eor	r2,r4,r5
	eor	r0,r0,r11,ror#25	@ Sigma1(e)
	and	r2,r2,r11
	add	r3,r3,r0
	eor	r2,r2,r5			@ Ch(e,f,g)
	add	r3,r3,r6
	mov	r6,r7,ror#2
	add	r3,r3,r2
	eor	r6,r6,r7,ror#13
	add	r3,r3,r12
	eor	r6,r6,r7,ror#22		@ Sigma0(a)
	orr	r0,r7,r8
	and	r2,r7,r8
	and	r0,r0,r9
	add	r6,r6,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r10,r10,r3
	add	r6,r6,r0
	ldr	r2,[sp,#7*4]		@ 22
	ldr	r12,[sp,#4*4]
	ldr	r3,[sp,#6*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#15*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r10,ror#6
	str	r3,[sp,#6*4]
	eor	r0,r0,r10,ror#11
	eor	r2,r11,r4
	eor	r0,r0,r10,ror#25	@ Sigma1(e)
	and	r2,r2,r10
	add	r3,r3,r0
	eor	r2,r2,r4			@ Ch(e,f,g)
	add	r3,r3,r5
	mov	r5,r6,ror#2
	add	r3,r3,r2
	eor	r5,r5,r6,ror#13
	add	r3,r3,r12
	eor	r5,r5,r6,ror#22		@ Sigma0(a)
	orr	r0,r6,r7
	and	r2,r6,r7
	and	r0,r0,r8
	add	r5,r5,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r9,r9,r3
	add	r5,r5,r0
	ldr	r2,[sp,#8*4]		@ 23
	ldr	r12,[sp,#5*4]
	ldr	r3,[sp,#7*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#0*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r9,ror#6
	str	r3,[sp,#7*4]
	eor	r0,r0,r9,ror#11
	eor	r2,r10,r11
	eor	r0,r0,r9,ror#25	@ Sigma1(e)
	and	r2,r2,r9
	add	r3,r3,r0
	eor	r2,r2,r11			@ Ch(e,f,g)
	add	r3,r3,r4
	mov	r4,r5,ror#2
	add	r3,r3,r2
	eor	r4,r4,r5,ror#13
	add	r3,r3,r12
	eor	r4,r4,r5,ror#22		@ Sigma0(a)
	orr	r0,r5,r6
	and	r2,r5,r6
	and	r0,r0,r7
	add	r4,r4,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r8,r8,r3
	add	r4,r4,r0
	ldr	r2,[sp,#9*4]		@ 24
	ldr	r12,[sp,#6*4]
	ldr	r3,[sp,#8*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#1*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r8,ror#6
	str	r3,[sp,#8*4]
	eor	r0,r0,r8,ror#11
	eor	r2,r9,r10
	eor	r0,r0,r8,ror#25	@ Sigma1(e)
	and	r2,r2,r8
	add	r3,r3,r0
	eor	r2,r2,r10			@ Ch(e,f,g)
	add	r3,r3,r11
	mov	r11,r4,ror#2
	add	r3,r3,r2
	eor	r11,r11,r4,ror#13
	add	r3,r3,r12
	eor	r11,r11,r4,ror#22		@ Sigma0(a)
	orr	r0,r4,r5
	and	r2,r4,r5
	and	r0,r0,r6
	add	r11,r11,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r7,r7,r3
	add	r11,r11,r0
	ldr	r2,[sp,#10*4]		@ 25
	ldr	r12,[sp,#7*4]
	ldr	r3,[sp,#9*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#2*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r7,ror#6
	str	r3,[sp,#9*4]
	eor	r0,r0,r7,ror#11
	eor	r2,r8,r9
	eor	r0,r0,r7,ror#25	@ Sigma1(e)
	and	r2,r2,r7
	add	r3,r3,r0
	eor	r2,r2,r9			@ Ch(e,f,g)
	add	r3,r3,r10
	mov	r10,r11,ror#2
	add	r3,r3,r2
	eor	r10,r10,r11,ror#13
	add	r3,r3,r12
	eor	r10,r10,r11,ror#22		@ Sigma0(a)
	orr	r0,r11,r4
	and	r2,r11,r4
	and	r0,r0,r5
	add	r10,r10,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r6,r6,r3
	add	r10,r10,r0
	ldr	r2,[sp,#11*4]		@ 26
	ldr	r12,[sp,#8*4]
	ldr	r3,[sp,#10*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#3*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r6,ror#6
	str	r3,[sp,#10*4]
	eor	r0,r0,r6,ror#11
	eor	r2,r7,r8
	eor	r0,r0,r6,ror#25	@ Sigma1(e)
	and	r2,r2,r6
	add	r3,r3,r0
	eor	r2,r2,r8			@ Ch(e,f,g)
	add	r3,r3,r9
	mov	r9,r10,ror#2
	add	r3,r3,r2
	eor	r9,r9,r10,ror#13
	add	r3,r3,r12
	eor	r9,r9,r10,ror#22		@ Sigma0(a)
	orr	r0,r10,r11
	and	r2,r10,r11
	and	r0,r0,r4
	add	r9,r9,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r5,r5,r3
	add	r9,r9,r0
	ldr	r2,[sp,#12*4]		@ 27
	ldr	r12,[sp,#9*4]
	ldr	r3,[sp,#11*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#4*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r5,ror#6
	str	r3,[sp,#11*4]
	eor	r0,r0,r5,ror#11
	eor	r2,r6,r7
	eor	r0,r0,r5,ror#25	@ Sigma1(e)
	and	r2,r2,r5
	add	r3,r3,r0
	eor	r2,r2,r7			@ Ch(e,f,g)
	add	r3,r3,r8
	mov	r8,r9,ror#2
	add	r3,r3,r2
	eor	r8,r8,r9,ror#13
	add	r3,r3,r12
	eor	r8,r8,r9,ror#22		@ Sigma0(a)
	orr	r0,r9,r10
	and	r2,r9,r10
	and	r0,r0,r11
	add	r8,r8,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r4,r4,r3
	add	r8,r8,r0
	ldr	r2,[sp,#13*4]		@ 28
	ldr	r12,[sp,#10*4]
	ldr	r3,[sp,#12*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#5*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r4,ror#6
	str	r3,[sp,#12*4]
	eor	r0,r0,r4,ror#11
	eor	r2,r5,r6
	eor	r0,r0,r4,ror#25	@ Sigma1(e)
	and	r2,r2,r4
	add	r3,r3,r0
	eor	r2,r2,r6			@ Ch(e,f,g)
	add	r3,r3,r7
	mov	r7,r8,ror#2
	add	r3,r3,r2
	eor	r7,r7,r8,ror#13
	add	r3,r3,r12
	eor	r7,r7,r8,ror#22		@ Sigma0(a)
	orr	r0,r8,r9
	and	r2,r8,r9
	and	r0,r0,r10
	add	r7,r7,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r11,r11,r3
	add	r7,r7,r0
	ldr	r2,[sp,#14*4]		@ 29
	ldr	r12,[sp,#11*4]
	ldr	r3,[sp,#13*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#6*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r11,ror#6
	str	r3,[sp,#13*4]
	eor	r0,r0,r11,ror#11
	eor	r2,r4,r5
	eor	r0,r0,r11,ror#25	@ Sigma1(e)
	and	r2,r2,r11
	add	r3,r3,r0
	eor	r2,r2,r5			@ Ch(e,f,g)
	add	r3,r3,r6
	mov	r6,r7,ror#2
	add	r3,r3,r2
	eor	r6,r6,r7,ror#13
	add	r3,r3,r12
	eor	r6,r6,r7,ror#22		@ Sigma0(a)
	orr	r0,r7,r8
	and	r2,r7,r8
	and	r0,r0,r9
	add	r6,r6,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r10,r10,r3
	add	r6,r6,r0
	ldr	r2,[sp,#15*4]		@ 30
	ldr	r12,[sp,#12*4]
	ldr	r3,[sp,#14*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#7*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r10,ror#6
	str	r3,[sp,#14*4]
	eor	r0,r0,r10,ror#11
	eor	r2,r11,r4
	eor	r0,r0,r10,ror#25	@ Sigma1(e)
	and	r2,r2,r10
	add	r3,r3,r0
	eor	r2,r2,r4			@ Ch(e,f,g)
	add	r3,r3,r5
	mov	r5,r6,ror#2
	add	r3,r3,r2
	eor	r5,r5,r6,ror#13
	add	r3,r3,r12
	eor	r5,r5,r6,ror#22		@ Sigma0(a)
	orr	r0,r6,r7
	and	r2,r6,r7
	and	r0,r0,r8
	add	r5,r5,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r9,r9,r3
	add	r5,r5,r0
	ldr	r2,[sp,#0*4]		@ 31
	ldr	r12,[sp,#13*4]
	ldr	r3,[sp,#15*4]
	mov	r0,r2,ror#7
	ldr	r1,[sp,#8*4]
	eor	r0,r0,r2,ror#18
	eor	r0,r0,r2,lsr#3	@ sigma0(X[i+1])
	mov	r2,r12,ror#17
	add	r3,r3,r0
	eor	r2,r2,r12,ror#19
	add	r3,r3,r1
	eor	r2,r2,r12,lsr#10	@ sigma1(X[i+14])
	add	r3,r3,r2
	ldr	r12,[r14],#4			@ *K256++
	mov	r0,r9,ror#6
	str	r3,[sp,#15*4]
	eor	r0,r0,r9,ror#11
	eor	r2,r10,r11
	eor	r0,r0,r9,ror#25	@ Sigma1(e)
	and	r2,r2,r9
	add	r3,r3,r0
	eor	r2,r2,r11			@ Ch(e,f,g)
	add	r3,r3,r4
	mov	r4,r5,ror#2
	add	r3,r3,r2
	eor	r4,r4,r5,ror#13
	add	r3,r3,r12
	eor	r4,r4,r5,ror#22		@ Sigma0(a)
	orr	r0,r5,r6
	and	r2,r5,r6
	and	r0,r0,r7
	add	r4,r4,r3
	orr	r0,r0,r2			@ Maj(a,b,c)
	add	r8,r8,r3
	add	r4,r4,r0
	and	r12,r12,#0xff
	cmp	r12,#0xf2
	bne	.Lrounds_16_xx

	ldr	r3,[sp,#16*4]		@ pull ctx
	ldr	r0,[r3,#0]
	ldr	r2,[r3,#4]
	ldr	r12,[r3,#8]
	add	r4,r4,r0
	ldr	r0,[r3,#12]
	add	r5,r5,r2
	ldr	r2,[r3,#16]
	add	r6,r6,r12
	ldr	r12,[r3,#20]
	add	r7,r7,r0
	ldr	r0,[r3,#24]
	add	r8,r8,r2
	ldr	r2,[r3,#28]
	add	r9,r9,r12
	ldr	r1,[sp,#17*4]		@ pull inp
	ldr	r12,[sp,#18*4]		@ pull inp+len
	add	r10,r10,r0
	add	r11,r11,r2
	stmia	r3,{r4,r5,r6,r7,r8,r9,r10,r11}
	cmp	r1,r12
	sub	r14,r14,#256	@ rewind Ktbl
	bne	.Loop

	add	sp,sp,#19*4	@ destroy frame
	ldmia	sp!,{r4-r12,lr}
	tst	lr,#1
	moveq	pc,lr			@ be binary compatible with V4, yet
	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
.asciz  "SHA256 block transform for ARMv4, CRYPTOGAMS by <appro@openssl.org>"
.align	2
