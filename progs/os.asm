
circular_queue:
0:	addi	$sp, $sp, 9
1:	sw	$a0, -6($sp)
2:	li	$t0, 0
3:	sw	$t0, -4($sp)
4:	li	$t1, 0
5:	sw	$t1, -3($sp)
6:	li	$t2, 0
7:	sw	$t2, 0($sp)
8:	li	$a0, 4
9:	lcd	$a0
10:	nop	
11:	in	$t3
12:	sw	$t3, 52($gp)
.L1	
13:	lw	$s0, -4($sp)
14:	lw	$s1, -6($sp)
15:	lt	$t4, $s0, $s1
16:	beq	$t4, $rzero, L2
17:	li	$a0, 12
18:	nop	
19:	out	$a0
20:	li	$a0, 13
21:	nop	
22:	out	$a0
23:	j	L1
.L2	
24:	li	$a0, 5
25:	lcd	$a0
26:	nop	
27:	in	$t5
28:	sw	$t5, 52($gp)
29:	jr	$ra

reset_queue:
30:	addi	$sp, $sp, 3
.L3	
31:	lw	$s0, 0($sp)
32:	li	$t0, 10
33:	lt	$t1, $s0, $t0
34:	beq	$t1, $rzero, L4
35:	la	$s1, 2($gp)
36:	add	$t2, $s1, $s0
37:	li	$t3, 0
38:	sw	$t3, 0($t2)
39:	addi	$t4, $s0, 1
40:	sw	$t4, 0($sp)
41:	lw	$s0, 0($sp)
42:	j	L3
.L4	
43:	li	$a0, 87
44:	nop	
45:	out	$a0
46:	jr	$ra

reset_pcs:
47:	addi	$sp, $sp, 3
.L5	
48:	lw	$s0, 0($sp)
49:	li	$t0, 10
50:	lt	$t1, $s0, $t0
51:	beq	$t1, $rzero, L6
52:	la	$s1, 32($gp)
53:	add	$t2, $s1, $s0
54:	li	$t3, 0
55:	sw	$t3, 0($t2)
56:	addi	$t4, $s0, 1
57:	sw	$t4, 0($sp)
58:	lw	$s0, 0($sp)
59:	j	L5
.L6	
60:	li	$a0, 47
61:	nop	
62:	out	$a0
63:	jr	$ra

process_handling:
64:	addi	$sp, $sp, 5
65:	li	$a0, 2
66:	lcd	$a0
67:	nop	
68:	in	$t0
69:	sw	$t0, -2($sp)
70:	lw	$s0, -2($sp)
71:	mov	$a0, $s0
72:	nop	
73:	out	$a0
74:	li	$t1, 0
75:	sw	$t1, -1($sp)
76:	li	$a0, 3
77:	lcd	$a0
.L7	
78:	lw	$s0, -1($sp)
79:	lw	$s1, -2($sp)
80:	lt	$t2, $s0, $s1
81:	beq	$t2, $rzero, L8
82:	nop	
83:	in	$t3
84:	sw	$t3, 0($sp)
85:	lw	$s2, 0($sp)
86:	mov	$a0, $s2
87:	nop	
88:	out	$a0
89:	la	$s3, 2($gp)
90:	add	$t4, $s3, $s0
91:	sw	$s2, 0($t4)
92:	la	$s4, 42($gp)
93:	add	$t5, $s4, $s0
94:	li	$t6, 0
95:	sw	$t6, 0($t5)
96:	addi	$t7, $s0, 1
97:	sw	$t7, -1($sp)
98:	lw	$s0, -1($sp)
99:	j	L7
.L8	
100:	lw	$s0, -2($sp)
101:	mov	$a0, $s0
102:	sw	$ra, -3($sp)
103:	jal	circular_queue
104:	subi	$sp, $sp, 9
105:	lw	$ra, -3($sp)
106:	mov	$s0, $v0
107:	sw	$ra, -3($sp)
108:	jal	reset_queue
109:	subi	$sp, $sp, 3
110:	lw	$ra, -3($sp)
111:	mov	$s0, $v0
112:	sw	$ra, -3($sp)
113:	jal	reset_pcs
114:	subi	$sp, $sp, 3
115:	lw	$ra, -3($sp)
116:	mov	$s0, $v0
117:	jr	$ra

bash:
118:	addi	$sp, $sp, 3
119:	li	$a0, 1
120:	lcd	$a0
121:	nop	
122:	in	$t0
123:	sw	$t0, 0($sp)
124:	lw	$s0, 0($sp)
125:	mov	$a0, $s0
126:	nop	
127:	out	$a0
128:	li	$t1, 1
129:	eq	$t2, $s0, $t1
130:	beq	$t2, $rzero, L9
131:	sw	$ra, -1($sp)
132:	jal	process_handling
133:	subi	$sp, $sp, 5
134:	lw	$ra, -1($sp)
135:	mov	$s0, $v0
.L9	
136:	jr	$ra

init_os:
137:	addi	$sp, $sp, 3
138:	li	$t0, 0
139:	sw	$t0, 0($sp)
140:	li	$t1, 10
141:	sw	$t1, 0($gp)
142:	li	$t2, 1024
143:	sw	$t2, 1($gp)
144:	la	$s0, 22($gp)
145:	li	$t3, 0
146:	sw	$t3, 1($s0)
147:	li	$t4, 0
148:	sw	$t4, 2($s0)
149:	li	$t5, 0
150:	sw	$t5, 3($s0)
.L10	
151:	lw	$s0, 0($sp)
152:	li	$t6, 10
153:	lt	$t7, $s0, $t6
154:	beq	$t7, $rzero, L11
155:	la	$s1, 2($gp)
156:	add	$t8, $s1, $s0
157:	li	$t9, 0
158:	sw	$t9, 0($t8)
159:	la	$s2, 42($gp)
160:	add	$t0, $s2, $s0
161:	li	$t1, 0
162:	sw	$t1, 0($t0)
163:	la	$s3, 32($gp)
164:	add	$t2, $s3, $s0
165:	li	$t3, 0
166:	sw	$t3, 0($t2)
167:	la	$s4, 12($gp)
168:	add	$t4, $s4, $s0
169:	sw	$s0, 0($t4)
170:	addi	$t5, $s0, 1
171:	sw	$t5, 0($sp)
172:	lw	$s0, 0($sp)
173:	j	L10
.L11	
174:	jr	$ra

main:
175:	addi	$sp, $gp, 1
176:	addi	$sp, $sp, 55
177:	li	$a0, 0
178:	lcd	$a0
179:	nop	
180:	in	$t0
181:	sw	$t0, 52($gp)
.L12	
182:	li	$t1, 1
183:	li	$t2, 2
184:	lt	$t3, $t1, $t2
185:	beq	$t3, $rzero, L13
186:	sw	$ra, 0($sp)
187:	jal	bash
188:	subi	$sp, $sp, 3
189:	lw	$ra, 0($sp)
190:	mov	$s0, $v0
191:	j	L12
.L13	
192:	subi	$sp, $sp, 1
193:	hlt	
