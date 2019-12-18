
minloc:
0:	addi	$sp, $sp, 8
1:	sw	$a0, -5($sp)
2:	sw	$a1, -4($sp)
3:	sw	$a2, -3($sp)
4:	lw	$s0, -4($sp)
5:	sw	$s0, 0($sp)
6:	lw	$s1, -5($sp)
7:	add	$t0, $s1, $s0
8:	lw	$t0, 0($t0)
9:	sw	$t0, -1($sp)
10:	addi	$t1, $s0, 1
11:	sw	$t1, -2($sp)
.L1	
12:	lw	$s0, -2($sp)
13:	lw	$s1, -3($sp)
14:	lt	$t2, $s0, $s1
15:	beq	$t2, $rzero, L3
16:	lw	$s2, -5($sp)
17:	add	$t3, $s2, $s0
18:	lw	$t3, 0($t3)
19:	lw	$s3, -1($sp)
20:	lt	$t4, $t3, $s3
21:	beq	$t4, $rzero, L2
22:	add	$t5, $s2, $s0
23:	lw	$t5, 0($t5)
24:	sw	$t5, -1($sp)
25:	lw	$s3, -1($sp)
26:	sw	$s0, 0($sp)
.L2	
27:	lw	$s0, -2($sp)
28:	addi	$t6, $s0, 1
29:	sw	$t6, -2($sp)
30:	lw	$s0, -2($sp)
31:	j	L1
.L3	
32:	lw	$s0, 0($sp)
33:	mov	$v0, $s0
34:	jr	$ra

sort:
35:	addi	$sp, $sp, 8
36:	sw	$a0, -5($sp)
37:	sw	$a1, -4($sp)
38:	sw	$a2, -3($sp)
39:	lw	$s0, -4($sp)
40:	sw	$s0, -2($sp)
.L4	
41:	lw	$s0, -3($sp)
42:	subi	$t0, $s0, 1
43:	lw	$s1, -2($sp)
44:	lt	$t1, $s1, $t0
45:	beq	$t1, $rzero, L5
46:	lw	$a0, -5($sp)
47:	mov	$a1, $s1
48:	mov	$a2, $s0
49:	sw	$ra, -6($sp)
50:	jal	minloc
51:	subi	$sp, $sp, 8
52:	lw	$ra, -6($sp)
53:	mov	$s0, $v0
54:	sw	$s0, -1($sp)
55:	lw	$s1, -5($sp)
56:	lw	$s2, -1($sp)
57:	add	$t2, $s1, $s2
58:	lw	$t2, 0($t2)
59:	sw	$t2, 0($sp)
60:	lw	$s3, -2($sp)
61:	add	$t3, $s1, $s3
62:	lw	$t3, 0($t3)
63:	add	$t4, $s1, $s2
64:	sw	$t3, 0($t4)
65:	add	$t5, $s1, $s3
66:	lw	$s4, 0($sp)
67:	sw	$s4, 0($t5)
68:	addi	$t6, $s3, 1
69:	sw	$t6, -2($sp)
70:	lw	$s3, -2($sp)
71:	j	L4
.L5	
72:	jr	$ra

main:
73:	addi	$sp, $gp, 1
74:	addi	$sp, $sp, 14
75:	li	$t0, 0
76:	sw	$t0, -2($sp)
.L6	
77:	lw	$s0, -2($sp)
78:	li	$t1, 4
79:	lt	$t2, $s0, $t1
80:	beq	$t2, $rzero, L7
81:	nop	
82:	sysin	
83:	nop	
84:	lw	$t3, $t3
85:	sw	$t3, -1($sp)
86:	la	$s1, 0($gp)
87:	add	$t4, $s1, $s0
88:	lw	$s2, -1($sp)
89:	sw	$s2, 0($t4)
90:	addi	$t5, $s0, 1
91:	sw	$t5, -2($sp)
92:	lw	$s0, -2($sp)
93:	j	L6
.L7	
94:	la	$a0, 0($gp)
95:	li	$a1, 0
96:	li	$a2, 4
97:	sw	$ra, -3($sp)
98:	jal	sort
99:	subi	$sp, $sp, 8
100:	lw	$ra, -3($sp)
101:	mov	$s0, $v0
102:	li	$t6, 0
103:	sw	$t6, -2($sp)
.L8	
104:	lw	$s0, -2($sp)
105:	li	$t7, 4
106:	lt	$t8, $s0, $t7
107:	beq	$t8, $rzero, L9
108:	la	$s1, 0($gp)
109:	add	$t9, $s1, $s0
110:	lw	$t9, 0($t9)
111:	sw	$t9, 0($sp)
112:	lw	$s2, 0($sp)
113:	mov	$a0, $s2
114:	nop	
115:	sysout	
116:	nop	
117:	addi	$t0, $s0, 1
118:	sw	$t0, -2($sp)
119:	lw	$s0, -2($sp)
120:	j	L8
.L9	
121:	subi	$sp, $sp, 4
122:	sysend	
