
load_proc_context:
0:	addi	$sp, $sp, 7
1:	sw	$a0, -4($sp)
2:	li	$a0, 89
3:	nop	
4:	out	$a0
5:	la	$s0, 23($gp)
6:	lw	$s1, -4($sp)
7:	add	$t0, $s0, $s1
8:	lw	$t0, 0($t0)
9:	sw	$t0, -3($sp)
10:	li	$t1, 0
11:	sw	$t1, -2($sp)
12:	mov	$a0, $s1
13:	nop	
14:	out	$a0
15:	la	$s2, 13($gp)
16:	lw	$t2, 3($s2)
17:	mov	$a0, $t2
18:	nop	
19:	out	$a0
20:	lw	$t3, 4($s2)
21:	mov	$a0, $t3
22:	nop	
23:	out	$a0
24:	lw	$s3, 1($gp)
25:	mov	$a0, $s3
26:	nop	
27:	out	$a0
28:	mult	$t4, $s3, $s1
29:	sw	$t4, 0($sp)
30:	lw	$s4, 0($sp)
31:	mov	$a0, $s4
32:	nop	
33:	out	$a0
.L1	
34:	lw	$s0, -2($sp)
35:	lw	$s1, -3($sp)
36:	lt	$t5, $s0, $s1
37:	beq	$t5, $rzero, L2
38:	lw	$s2, 0($sp)
39:	mov	$a0, $s2
40:	lhd	$t6, $a0
41:	sw	$t6, -1($sp)
42:	lw	$s3, -1($sp)
43:	mov	$a0, $s3
44:	mov	$a1, $s0
45:	smemproc	$a0, $a1
46:	addi	$t7, $s0, 1
47:	sw	$t7, -2($sp)
48:	lw	$s0, -2($sp)
49:	addi	$t8, $s2, 1
50:	sw	$t8, 0($sp)
51:	lw	$s2, 0($sp)
52:	j	L1
.L2	
53:	lw	$s0, -2($sp)
54:	mov	$a0, $s0
55:	nop	
56:	out	$a0
57:	li	$a0, 99
58:	nop	
59:	out	$a0
60:	jr	$ra

circular_queue:
61:	addi	$sp, $sp, 10
62:	sw	$a0, -7($sp)
63:	li	$t0, 0
64:	sw	$t0, -5($sp)
65:	li	$t1, 0
66:	sw	$t1, -4($sp)
67:	li	$t2, 0
68:	sw	$t2, -1($sp)
69:	li	$a0, 4
70:	lcd	$a0
71:	nop	
72:	in	$t3
73:	sw	$t3, 2($gp)
.L3	
74:	lw	$s0, -5($sp)
75:	lw	$s1, -7($sp)
76:	lt	$t4, $s0, $s1
77:	beq	$t4, $rzero, L10
78:	li	$a0, 12
79:	nop	
80:	out	$a0
81:	li	$a0, 13
82:	nop	
83:	out	$a0
84:	la	$s2, 3($gp)
85:	lw	$s3, -4($sp)
86:	add	$t5, $s2, $s3
87:	lw	$t5, 0($t5)
88:	sw	$t5, -6($sp)
89:	lw	$s4, -6($sp)
90:	sw	$s4, -3($sp)
91:	la	$s5, 43($gp)
92:	lw	$s6, -3($sp)
93:	add	$t6, $s5, $s6
94:	lw	$t6, 0($t6)
95:	li	$t7, 0
96:	eq	$t8, $t6, $t7
97:	beq	$t8, $rzero, L7
98:	mov	$a0, $s6
99:	nop	
100:	out	$a0
101:	la	$s7, 33($gp)
102:	add	$t9, $s7, $s6
103:	lw	$t9, 0($t9)
104:	sw	$t9, -1($sp)
105:	lw	$s8, -1($sp)
106:	mov	$a0, $s8
107:	setpc	$a0
108:	mov	$a0, $s6
109:	sw	$ra, -8($sp)
110:	jal	load_proc_context
111:	subi	$sp, $sp, 7
112:	lw	$ra, -8($sp)
113:	mov	$s0, $v0
114:	lw	$s1, -3($sp)
115:	mov	$a0, $s1
116:	nop	
117:	chwrt	
118:	mov	$a0, $a0
119:	chrd	
120:	mov	$s9, $a0
121:	sprc	$s9
122:	nop	
123:	chrd	
124:	chwrt	
125:	nop	
126:	li	$a0, 70
127:	nop	
128:	out	$a0
129:	mov	$s2, $v1
130:	sw	$s2, 0($sp)
131:	lw	$s3, 0($sp)
132:	mov	$a0, $s3
133:	nop	
134:	out	$a0
135:	getpc	
136:	mov	$s4, $v1
137:	la	$s5, 33($gp)
138:	add	$t0, $s5, $s1
139:	sw	$s4, 0($t0)
140:	li	$t1, 1
141:	eq	$t2, $s3, $t1
142:	beq	$t2, $rzero, L4
143:	mov	$a0, $s3
144:	nop	
145:	out	$a0
146:	nop	
147:	in	$t3
148:	sw	$t3, -2($sp)
149:	lw	$s6, -2($sp)
150:	mov	$a0, $s6
151:	nop	
152:	out	$a0
153:	mov	$a0, $s6
154:	chwrt	
155:	mov	$v1, $a0
156:	chwrt	
.L4	
157:	lw	$s0, 0($sp)
158:	li	$t4, 2
159:	eq	$t5, $s0, $t4
160:	beq	$t5, $rzero, L5
161:	mov	$a0, $s0
162:	nop	
163:	out	$a0
164:	chrd	
165:	mov	$s1, $v1
166:	chrd	
167:	sw	$s1, -2($sp)
168:	lw	$s2, -2($sp)
169:	mov	$a0, $s2
170:	nop	
171:	out	$a0
.L5	
172:	lw	$s0, 0($sp)
173:	li	$t6, 3
174:	eq	$t7, $s0, $t6
175:	beq	$t7, $rzero, L6
176:	mov	$a0, $s0
177:	nop	
178:	out	$a0
179:	lw	$s1, -3($sp)
180:	mov	$a0, $s1
181:	nop	
182:	out	$a0
183:	la	$s2, 43($gp)
184:	add	$t8, $s2, $s1
185:	li	$t9, 1
186:	sw	$t9, 0($t8)
187:	lw	$s3, -5($sp)
188:	addi	$t0, $s3, 1
189:	sw	$t0, -5($sp)
190:	lw	$s3, -5($sp)
.L6	
.L7	
191:	lw	$s0, -7($sp)
192:	subi	$t1, $s0, 1
193:	lw	$s1, -4($sp)
194:	lt	$t2, $s1, $t1
195:	beq	$t2, $rzero, L8
196:	addi	$t3, $s1, 1
197:	sw	$t3, -4($sp)
198:	lw	$s1, -4($sp)
199:	j	L9
.L8	
200:	li	$t4, 0
201:	sw	$t4, -4($sp)
.L9	
202:	j	L3
.L10	
203:	li	$a0, 5
204:	lcd	$a0
205:	nop	
206:	in	$t5
207:	sw	$t5, 2($gp)
208:	jr	$ra

reset_queue:
209:	addi	$sp, $sp, 3
.L11	
210:	lw	$s0, 0($sp)
211:	li	$t0, 10
212:	lt	$t1, $s0, $t0
213:	beq	$t1, $rzero, L12
214:	la	$s1, 3($gp)
215:	add	$t2, $s1, $s0
216:	li	$t3, 0
217:	sw	$t3, 0($t2)
218:	addi	$t4, $s0, 1
219:	sw	$t4, 0($sp)
220:	lw	$s0, 0($sp)
221:	j	L11
.L12	
222:	li	$a0, 87
223:	nop	
224:	out	$a0
225:	jr	$ra

reset_pcs:
226:	addi	$sp, $sp, 3
.L13	
227:	lw	$s0, 0($sp)
228:	li	$t0, 10
229:	lt	$t1, $s0, $t0
230:	beq	$t1, $rzero, L14
231:	la	$s1, 33($gp)
232:	add	$t2, $s1, $s0
233:	li	$t3, 0
234:	sw	$t3, 0($t2)
235:	addi	$t4, $s0, 1
236:	sw	$t4, 0($sp)
237:	lw	$s0, 0($sp)
238:	j	L13
.L14	
239:	li	$a0, 47
240:	nop	
241:	out	$a0
242:	jr	$ra

process_handling:
243:	addi	$sp, $sp, 5
244:	li	$a0, 2
245:	lcd	$a0
246:	nop	
247:	in	$t0
248:	sw	$t0, -2($sp)
249:	lw	$s0, -2($sp)
250:	mov	$a0, $s0
251:	nop	
252:	out	$a0
253:	li	$t1, 0
254:	sw	$t1, -1($sp)
255:	li	$a0, 3
256:	lcd	$a0
.L15	
257:	lw	$s0, -1($sp)
258:	lw	$s1, -2($sp)
259:	lt	$t2, $s0, $s1
260:	beq	$t2, $rzero, L16
261:	nop	
262:	in	$t3
263:	sw	$t3, 0($sp)
264:	lw	$s2, 0($sp)
265:	mov	$a0, $s2
266:	nop	
267:	out	$a0
268:	la	$s3, 3($gp)
269:	add	$t4, $s3, $s0
270:	sw	$s2, 0($t4)
271:	la	$s4, 43($gp)
272:	add	$t5, $s4, $s0
273:	li	$t6, 0
274:	sw	$t6, 0($t5)
275:	addi	$t7, $s0, 1
276:	sw	$t7, -1($sp)
277:	lw	$s0, -1($sp)
278:	j	L15
.L16	
279:	lw	$s0, -2($sp)
280:	mov	$a0, $s0
281:	sw	$ra, -3($sp)
282:	jal	circular_queue
283:	subi	$sp, $sp, 10
284:	lw	$ra, -3($sp)
285:	mov	$s0, $v0
286:	sw	$ra, -3($sp)
287:	jal	reset_queue
288:	subi	$sp, $sp, 3
289:	lw	$ra, -3($sp)
290:	mov	$s0, $v0
291:	sw	$ra, -3($sp)
292:	jal	reset_pcs
293:	subi	$sp, $sp, 3
294:	lw	$ra, -3($sp)
295:	mov	$s0, $v0
296:	jr	$ra

bash:
297:	addi	$sp, $sp, 3
298:	li	$a0, 1
299:	lcd	$a0
300:	nop	
301:	in	$t0
302:	sw	$t0, 0($sp)
303:	lw	$s0, 0($sp)
304:	mov	$a0, $s0
305:	nop	
306:	out	$a0
307:	li	$t1, 1
308:	eq	$t2, $s0, $t1
309:	beq	$t2, $rzero, L17
310:	sw	$ra, -1($sp)
311:	jal	process_handling
312:	subi	$sp, $sp, 5
313:	lw	$ra, -1($sp)
314:	mov	$s0, $v0
.L17	
315:	jr	$ra

init_os:
316:	addi	$sp, $sp, 3
317:	li	$t0, 0
318:	sw	$t0, 0($sp)
319:	li	$t1, 10
320:	sw	$t1, 0($gp)
321:	li	$t2, 1024
322:	sw	$t2, 1($gp)
323:	la	$s0, 23($gp)
324:	li	$t3, 50
325:	sw	$t3, 1($s0)
326:	li	$t4, 0
327:	sw	$t4, 2($s0)
328:	li	$t5, 0
329:	sw	$t5, 3($s0)
.L18	
330:	lw	$s0, 0($sp)
331:	li	$t6, 10
332:	lt	$t7, $s0, $t6
333:	beq	$t7, $rzero, L19
334:	la	$s1, 3($gp)
335:	add	$t8, $s1, $s0
336:	li	$t9, 0
337:	sw	$t9, 0($t8)
338:	la	$s2, 43($gp)
339:	add	$t0, $s2, $s0
340:	li	$t1, 0
341:	sw	$t1, 0($t0)
342:	la	$s3, 33($gp)
343:	add	$t2, $s3, $s0
344:	li	$t3, 0
345:	sw	$t3, 0($t2)
346:	la	$s4, 13($gp)
347:	add	$t4, $s4, $s0
348:	sw	$s0, 0($t4)
349:	addi	$t5, $s0, 1
350:	sw	$t5, 0($sp)
351:	lw	$s0, 0($sp)
352:	j	L18
.L19	
353:	jr	$ra

main:
354:	addi	$sp, $gp, 1
355:	addi	$sp, $sp, 54
356:	sw	$ra, 0($sp)
357:	jal	init_os
358:	subi	$sp, $sp, 3
359:	lw	$ra, 0($sp)
360:	mov	$s0, $v0
361:	li	$a0, 0
362:	lcd	$a0
363:	nop	
364:	in	$t0
365:	sw	$t0, 2($gp)
.L20	
366:	li	$t1, 1
367:	li	$t2, 2
368:	lt	$t3, $t1, $t2
369:	beq	$t3, $rzero, L21
370:	sw	$ra, 0($sp)
371:	jal	bash
372:	subi	$sp, $sp, 3
373:	lw	$ra, 0($sp)
374:	mov	$s0, $v0
375:	j	L20
.L21	
376:	subi	$sp, $sp, 1
377:	hlt	
