
circular_queue:
0:	addi	$sp, $sp, 3
1:	sw	$a0, 0($sp)
2:	li	$a0, 90
3:	out	$a0
4:	jr	$ra

reset_queue:
5:	addi	$sp, $sp, 3
.L1	
6:	lw	$s0, 0($sp)
7:	li	$t0, 10
8:	lt	$t1, $s0, $t0
9:	beq	$t1, $rzero, L2
10:	la	$s1, 2($gp)
11:	add	$t2, $s1, $s0
12:	li	$t3, 0
13:	sw	$t3, 0($t2)
14:	addi	$t4, $s0, 1
15:	sw	$t4, 0($sp)
16:	lw	$s0, 0($sp)
17:	j	L1
.L2	
18:	li	$a0, 87
19:	out	$a0
20:	jr	$ra

reset_pcs:
21:	addi	$sp, $sp, 3
.L3	
22:	lw	$s0, 0($sp)
23:	li	$t0, 10
24:	lt	$t1, $s0, $t0
25:	beq	$t1, $rzero, L4
26:	la	$s1, 32($gp)
27:	add	$t2, $s1, $s0
28:	li	$t3, 0
29:	sw	$t3, 0($t2)
30:	addi	$t4, $s0, 1
31:	sw	$t4, 0($sp)
32:	lw	$s0, 0($sp)
33:	j	L3
.L4	
34:	li	$a0, 47
35:	out	$a0
36:	jr	$ra

process_handling:
37:	addi	$sp, $sp, 5
38:	li	$a0, 2
39:	lcd	$a0
40:	nop	
41:	in	$t0
42:	sw	$t0, -2($sp)
43:	lw	$s0, -2($sp)
44:	mov	$a0, $s0
45:	out	$a0
46:	li	$t1, 0
47:	sw	$t1, -1($sp)
48:	li	$a0, 3
49:	lcd	$a0
.L5	
50:	lw	$s0, -1($sp)
51:	lw	$s1, -2($sp)
52:	lt	$t2, $s0, $s1
53:	beq	$t2, $rzero, L6
54:	nop	
55:	in	$t3
56:	sw	$t3, 0($sp)
57:	lw	$s2, 0($sp)
58:	mov	$a0, $s2
59:	out	$a0
60:	la	$s3, 2($gp)
61:	add	$t4, $s3, $s0
62:	sw	$s2, 0($t4)
63:	la	$s4, 42($gp)
64:	add	$t5, $s4, $s0
65:	li	$t6, 0
66:	sw	$t6, 0($t5)
67:	addi	$t7, $s0, 1
68:	sw	$t7, -1($sp)
69:	lw	$s0, -1($sp)
70:	j	L5
.L6	
71:	lw	$s0, -2($sp)
72:	mov	$a0, $s0
73:	sw	$ra, -3($sp)
74:	jal	circular_queue
75:	subi	$sp, $sp, 3
76:	lw	$ra, -3($sp)
77:	mov	$s0, $v0
78:	sw	$ra, -3($sp)
79:	jal	reset_queue
80:	subi	$sp, $sp, 3
81:	lw	$ra, -3($sp)
82:	mov	$s0, $v0
83:	sw	$ra, -3($sp)
84:	jal	reset_pcs
85:	subi	$sp, $sp, 3
86:	lw	$ra, -3($sp)
87:	mov	$s0, $v0
88:	jr	$ra

bash:
89:	addi	$sp, $sp, 3
90:	li	$a0, 1
91:	lcd	$a0
92:	nop	
93:	in	$t0
94:	sw	$t0, 0($sp)
95:	lw	$s0, 0($sp)
96:	mov	$a0, $s0
97:	out	$a0
98:	li	$t1, 1
99:	eq	$t2, $s0, $t1
100:	beq	$t2, $rzero, L7
101:	sw	$ra, -1($sp)
102:	jal	process_handling
103:	subi	$sp, $sp, 5
104:	lw	$ra, -1($sp)
105:	mov	$s0, $v0
.L7	
106:	jr	$ra

init_os:
107:	addi	$sp, $sp, 3
108:	li	$t0, 0
109:	sw	$t0, 0($sp)
110:	li	$t1, 10
111:	sw	$t1, 0($gp)
112:	li	$t2, 2096
113:	sw	$t2, 1($gp)
114:	la	$s0, 22($gp)
115:	li	$t3, 0
116:	sw	$t3, 1($s0)
117:	li	$t4, 0
118:	sw	$t4, 2($s0)
119:	li	$t5, 0
120:	sw	$t5, 3($s0)
.L8	
121:	lw	$s0, 0($sp)
122:	li	$t6, 10
123:	lt	$t7, $s0, $t6
124:	beq	$t7, $rzero, L9
125:	la	$s1, 2($gp)
126:	add	$t8, $s1, $s0
127:	li	$t9, 0
128:	sw	$t9, 0($t8)
129:	la	$s2, 42($gp)
130:	add	$t0, $s2, $s0
131:	li	$t1, 0
132:	sw	$t1, 0($t0)
133:	la	$s3, 32($gp)
134:	add	$t2, $s3, $s0
135:	li	$t3, 0
136:	sw	$t3, 0($t2)
137:	la	$s4, 12($gp)
138:	add	$t4, $s4, $s0
139:	sw	$s0, 0($t4)
140:	addi	$t5, $s0, 1
141:	sw	$t5, 0($sp)
142:	lw	$s0, 0($sp)
143:	j	L8
.L9	
144:	jr	$ra

main:
145:	addi	$sp, $gp, 1
146:	addi	$sp, $sp, 54
147:	li	$a0, 0
148:	lcd	$a0
149:	nop	
150:	in	$t0
151:	sw	$t0, 52($gp)
.L10	
152:	li	$t1, 1
153:	li	$t2, 2
154:	lt	$t3, $t1, $t2
155:	beq	$t3, $rzero, L11
156:	sw	$ra, 0($sp)
157:	jal	bash
158:	subi	$sp, $sp, 3
159:	lw	$ra, 0($sp)
160:	mov	$s0, $v0
161:	j	L10
.L11	
162:	subi	$sp, $sp, 1
163:	hlt	
