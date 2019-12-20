
store_proc_context:
0:	addi	$sp, $sp, 4
1:	sw	$a0, -1($sp)
2:	lw	$s0, -1($sp)
3:	addi	$t0, $s0, 1
4:	sw	$t0, -1($sp)
5:	lw	$s0, -1($sp)
6:	lw	$s1, 1($gp)
7:	mult	$t1, $s0, $s1
8:	sw	$t1, 0($sp)
9:	li	$a0, 1
10:	lw	$s2, 0($sp)
11:	mov	$a1, $s2
12:	li	$a2, 1
13:	sub	$a1, $a1, $a2
14:	chrd	
15:	mov	$a0, $v0
16:	chrd	
17:	sw	$a0, 0($a1)
18:	li	$a0, 2
19:	mov	$a1, $s2
20:	li	$a2, 2
21:	sub	$a1, $a1, $a2
22:	chrd	
23:	mov	$a0, $v1
24:	chrd	
25:	sw	$a0, 0($a1)
26:	li	$a0, 3
27:	mov	$a1, $s2
28:	li	$a2, 3
29:	sub	$a1, $a1, $a2
30:	chrd	
31:	mov	$a0, $out1
32:	chrd	
33:	sw	$a0, 0($a1)
34:	li	$a0, 4
35:	mov	$a1, $s2
36:	li	$a2, 4
37:	sub	$a1, $a1, $a2
38:	chrd	
39:	mov	$a0, $out2
40:	chrd	
41:	sw	$a0, 0($a1)
42:	li	$a0, 5
43:	mov	$a1, $s2
44:	li	$a2, 5
45:	sub	$a1, $a1, $a2
46:	chrd	
47:	mov	$a0, $gp
48:	chrd	
49:	sw	$a0, 0($a1)
50:	li	$a0, 6
51:	mov	$a1, $s2
52:	li	$a2, 6
53:	sub	$a1, $a1, $a2
54:	chrd	
55:	mov	$a0, $a0
56:	chrd	
57:	sw	$a0, 0($a1)
58:	li	$a0, 7
59:	mov	$a1, $s2
60:	li	$a2, 7
61:	sub	$a1, $a1, $a2
62:	chrd	
63:	mov	$a0, $a1
64:	chrd	
65:	sw	$a0, 0($a1)
66:	li	$a0, 8
67:	mov	$a1, $s2
68:	li	$a2, 8
69:	sub	$a1, $a1, $a2
70:	chrd	
71:	mov	$a0, $a2
72:	chrd	
73:	sw	$a0, 0($a1)
74:	li	$a0, 9
75:	mov	$a1, $s2
76:	li	$a2, 9
77:	sub	$a1, $a1, $a2
78:	chrd	
79:	mov	$a0, $a3
80:	chrd	
81:	sw	$a0, 0($a1)
82:	li	$a0, 10
83:	mov	$a1, $s2
84:	li	$a2, 10
85:	sub	$a1, $a1, $a2
86:	chrd	
87:	mov	$a0, $s0
88:	chrd	
89:	sw	$a0, 0($a1)
90:	li	$a0, 11
91:	mov	$a1, $s2
92:	li	$a2, 11
93:	sub	$a1, $a1, $a2
94:	chrd	
95:	mov	$a0, $s1
96:	chrd	
97:	sw	$a0, 0($a1)
98:	li	$a0, 12
99:	mov	$a1, $s2
100:	li	$a2, 12
101:	sub	$a1, $a1, $a2
102:	chrd	
103:	mov	$a0, $s2
104:	chrd	
105:	sw	$a0, 0($a1)
106:	li	$a0, 13
107:	mov	$a1, $s2
108:	li	$a2, 13
109:	sub	$a1, $a1, $a2
110:	chrd	
111:	mov	$a0, $s3
112:	chrd	
113:	sw	$a0, 0($a1)
114:	li	$a0, 14
115:	mov	$a1, $s2
116:	li	$a2, 14
117:	sub	$a1, $a1, $a2
118:	chrd	
119:	mov	$a0, $s4
120:	chrd	
121:	sw	$a0, 0($a1)
122:	li	$a0, 15
123:	mov	$a1, $s2
124:	li	$a2, 15
125:	sub	$a1, $a1, $a2
126:	chrd	
127:	mov	$a0, $s5
128:	chrd	
129:	sw	$a0, 0($a1)
130:	li	$a0, 16
131:	mov	$a1, $s2
132:	li	$a2, 16
133:	sub	$a1, $a1, $a2
134:	chrd	
135:	mov	$a0, $s6
136:	chrd	
137:	sw	$a0, 0($a1)
138:	li	$a0, 17
139:	mov	$a1, $s2
140:	li	$a2, 17
141:	sub	$a1, $a1, $a2
142:	chrd	
143:	mov	$a0, $s7
144:	chrd	
145:	sw	$a0, 0($a1)
146:	li	$a0, 18
147:	mov	$a1, $s2
148:	li	$a2, 18
149:	sub	$a1, $a1, $a2
150:	chrd	
151:	mov	$a0, $s8
152:	chrd	
153:	sw	$a0, 0($a1)
154:	li	$a0, 19
155:	mov	$a1, $s2
156:	li	$a2, 19
157:	sub	$a1, $a1, $a2
158:	chrd	
159:	mov	$a0, $s9
160:	chrd	
161:	sw	$a0, 0($a1)
162:	li	$a0, 20
163:	mov	$a1, $s2
164:	li	$a2, 20
165:	sub	$a1, $a1, $a2
166:	chrd	
167:	mov	$a0, $t0
168:	chrd	
169:	sw	$a0, 0($a1)
170:	li	$a0, 21
171:	mov	$a1, $s2
172:	li	$a2, 21
173:	sub	$a1, $a1, $a2
174:	chrd	
175:	mov	$a0, $t1
176:	chrd	
177:	sw	$a0, 0($a1)
178:	li	$a0, 22
179:	mov	$a1, $s2
180:	li	$a2, 22
181:	sub	$a1, $a1, $a2
182:	chrd	
183:	mov	$a0, $t2
184:	chrd	
185:	sw	$a0, 0($a1)
186:	li	$a0, 23
187:	mov	$a1, $s2
188:	li	$a2, 23
189:	sub	$a1, $a1, $a2
190:	chrd	
191:	mov	$a0, $t3
192:	chrd	
193:	sw	$a0, 0($a1)
194:	li	$a0, 24
195:	mov	$a1, $s2
196:	li	$a2, 24
197:	sub	$a1, $a1, $a2
198:	chrd	
199:	mov	$a0, $t4
200:	chrd	
201:	sw	$a0, 0($a1)
202:	li	$a0, 25
203:	mov	$a1, $s2
204:	li	$a2, 25
205:	sub	$a1, $a1, $a2
206:	chrd	
207:	mov	$a0, $t5
208:	chrd	
209:	sw	$a0, 0($a1)
210:	li	$a0, 26
211:	mov	$a1, $s2
212:	li	$a2, 26
213:	sub	$a1, $a1, $a2
214:	chrd	
215:	mov	$a0, $t6
216:	chrd	
217:	sw	$a0, 0($a1)
218:	li	$a0, 27
219:	mov	$a1, $s2
220:	li	$a2, 27
221:	sub	$a1, $a1, $a2
222:	chrd	
223:	mov	$a0, $t7
224:	chrd	
225:	sw	$a0, 0($a1)
226:	li	$a0, 28
227:	mov	$a1, $s2
228:	li	$a2, 28
229:	sub	$a1, $a1, $a2
230:	chrd	
231:	mov	$a0, $t8
232:	chrd	
233:	sw	$a0, 0($a1)
234:	li	$a0, 29
235:	mov	$a1, $s2
236:	li	$a2, 29
237:	sub	$a1, $a1, $a2
238:	chrd	
239:	mov	$a0, $t9
240:	chrd	
241:	sw	$a0, 0($a1)
242:	li	$a0, 30
243:	mov	$a1, $s2
244:	li	$a2, 30
245:	sub	$a1, $a1, $a2
246:	chrd	
247:	mov	$a0, $sp
248:	chrd	
249:	sw	$a0, 0($a1)
250:	li	$a0, 31
251:	mov	$a1, $s2
252:	li	$a2, 31
253:	sub	$a1, $a1, $a2
254:	chrd	
255:	mov	$a0, $ra
256:	chrd	
257:	sw	$a0, 0($a1)
258:	li	$a0, 69
259:	out	$a0
260:	jr	$ra

load_proc_context:
261:	addi	$sp, $sp, 7
262:	sw	$a0, -4($sp)
263:	li	$a0, 89
264:	out	$a0
265:	la	$s0, 23($gp)
266:	lw	$s1, -4($sp)
267:	add	$t0, $s0, $s1
268:	lw	$t0, 0($t0)
269:	sw	$t0, -3($sp)
270:	li	$t1, 0
271:	sw	$t1, -2($sp)
272:	lw	$s2, 1($gp)
273:	mult	$t2, $s2, $s1
274:	sw	$t2, 0($sp)
275:	lw	$s3, 0($sp)
276:	mov	$a0, $s3
277:	out	$a0
.L1	
278:	lw	$s0, -2($sp)
279:	lw	$s1, -3($sp)
280:	lt	$t3, $s0, $s1
281:	beq	$t3, $rzero, L2
282:	lw	$s2, 0($sp)
283:	mov	$a0, $s2
284:	lhd	$t4, $a0
285:	sw	$t4, -1($sp)
286:	lw	$s3, -1($sp)
287:	mov	$a0, $s3
288:	mov	$a1, $s0
289:	smemproc	$a0, $a1
290:	addi	$t5, $s0, 1
291:	sw	$t5, -2($sp)
292:	lw	$s0, -2($sp)
293:	addi	$t6, $s2, 1
294:	sw	$t6, 0($sp)
295:	lw	$s2, 0($sp)
296:	j	L1
.L2	
297:	lw	$s0, -4($sp)
298:	addi	$t7, $s0, 1
299:	sw	$t7, -4($sp)
300:	lw	$s0, -4($sp)
301:	lw	$s1, 1($gp)
302:	mult	$t8, $s0, $s1
303:	sw	$t8, -2($sp)
304:	li	$a0, 1
305:	lw	$s2, -2($sp)
306:	mov	$a1, $s2
307:	li	$a2, 1
308:	sub	$a1, $a1, $a2
309:	chwrt	
310:	lw	$v0, 0($a1)
311:	chwrt	
312:	li	$a0, 2
313:	mov	$a1, $s2
314:	li	$a2, 2
315:	sub	$a1, $a1, $a2
316:	chwrt	
317:	lw	$v1, 0($a1)
318:	chwrt	
319:	li	$a0, 3
320:	mov	$a1, $s2
321:	li	$a2, 3
322:	sub	$a1, $a1, $a2
323:	chwrt	
324:	lw	$out1, 0($a1)
325:	chwrt	
326:	li	$a0, 4
327:	mov	$a1, $s2
328:	li	$a2, 4
329:	sub	$a1, $a1, $a2
330:	chwrt	
331:	lw	$out2, 0($a1)
332:	chwrt	
333:	li	$a0, 5
334:	mov	$a1, $s2
335:	li	$a2, 5
336:	sub	$a1, $a1, $a2
337:	chwrt	
338:	lw	$gp, 0($a1)
339:	chwrt	
340:	li	$a0, 6
341:	mov	$a1, $s2
342:	li	$a2, 6
343:	sub	$a1, $a1, $a2
344:	chwrt	
345:	lw	$a0, 0($a1)
346:	chwrt	
347:	li	$a0, 7
348:	mov	$a1, $s2
349:	li	$a2, 7
350:	sub	$a1, $a1, $a2
351:	chwrt	
352:	lw	$a1, 0($a1)
353:	chwrt	
354:	li	$a0, 8
355:	mov	$a1, $s2
356:	li	$a2, 8
357:	sub	$a1, $a1, $a2
358:	chwrt	
359:	lw	$a2, 0($a1)
360:	chwrt	
361:	li	$a0, 9
362:	mov	$a1, $s2
363:	li	$a2, 9
364:	sub	$a1, $a1, $a2
365:	chwrt	
366:	lw	$a3, 0($a1)
367:	chwrt	
368:	li	$a0, 10
369:	mov	$a1, $s2
370:	li	$a2, 10
371:	sub	$a1, $a1, $a2
372:	chwrt	
373:	lw	$s0, 0($a1)
374:	chwrt	
375:	li	$a0, 11
376:	mov	$a1, $s2
377:	li	$a2, 11
378:	sub	$a1, $a1, $a2
379:	chwrt	
380:	lw	$s1, 0($a1)
381:	chwrt	
382:	li	$a0, 12
383:	mov	$a1, $s2
384:	li	$a2, 12
385:	sub	$a1, $a1, $a2
386:	chwrt	
387:	lw	$s2, 0($a1)
388:	chwrt	
389:	li	$a0, 13
390:	mov	$a1, $s2
391:	li	$a2, 13
392:	sub	$a1, $a1, $a2
393:	chwrt	
394:	lw	$s3, 0($a1)
395:	chwrt	
396:	li	$a0, 14
397:	mov	$a1, $s2
398:	li	$a2, 14
399:	sub	$a1, $a1, $a2
400:	chwrt	
401:	lw	$s4, 0($a1)
402:	chwrt	
403:	li	$a0, 15
404:	mov	$a1, $s2
405:	li	$a2, 15
406:	sub	$a1, $a1, $a2
407:	chwrt	
408:	lw	$s5, 0($a1)
409:	chwrt	
410:	li	$a0, 16
411:	mov	$a1, $s2
412:	li	$a2, 16
413:	sub	$a1, $a1, $a2
414:	chwrt	
415:	lw	$s6, 0($a1)
416:	chwrt	
417:	li	$a0, 17
418:	mov	$a1, $s2
419:	li	$a2, 17
420:	sub	$a1, $a1, $a2
421:	chwrt	
422:	lw	$s7, 0($a1)
423:	chwrt	
424:	li	$a0, 18
425:	mov	$a1, $s2
426:	li	$a2, 18
427:	sub	$a1, $a1, $a2
428:	chwrt	
429:	lw	$s8, 0($a1)
430:	chwrt	
431:	li	$a0, 19
432:	mov	$a1, $s2
433:	li	$a2, 19
434:	sub	$a1, $a1, $a2
435:	chwrt	
436:	lw	$s9, 0($a1)
437:	chwrt	
438:	li	$a0, 20
439:	mov	$a1, $s2
440:	li	$a2, 20
441:	sub	$a1, $a1, $a2
442:	chwrt	
443:	lw	$t0, 0($a1)
444:	chwrt	
445:	li	$a0, 21
446:	mov	$a1, $s2
447:	li	$a2, 21
448:	sub	$a1, $a1, $a2
449:	chwrt	
450:	lw	$t1, 0($a1)
451:	chwrt	
452:	li	$a0, 22
453:	mov	$a1, $s2
454:	li	$a2, 22
455:	sub	$a1, $a1, $a2
456:	chwrt	
457:	lw	$t2, 0($a1)
458:	chwrt	
459:	li	$a0, 23
460:	mov	$a1, $s2
461:	li	$a2, 23
462:	sub	$a1, $a1, $a2
463:	chwrt	
464:	lw	$t3, 0($a1)
465:	chwrt	
466:	li	$a0, 24
467:	mov	$a1, $s2
468:	li	$a2, 24
469:	sub	$a1, $a1, $a2
470:	chwrt	
471:	lw	$t4, 0($a1)
472:	chwrt	
473:	li	$a0, 25
474:	mov	$a1, $s2
475:	li	$a2, 25
476:	sub	$a1, $a1, $a2
477:	chwrt	
478:	lw	$t5, 0($a1)
479:	chwrt	
480:	li	$a0, 26
481:	mov	$a1, $s2
482:	li	$a2, 26
483:	sub	$a1, $a1, $a2
484:	chwrt	
485:	lw	$t6, 0($a1)
486:	chwrt	
487:	li	$a0, 27
488:	mov	$a1, $s2
489:	li	$a2, 27
490:	sub	$a1, $a1, $a2
491:	chwrt	
492:	lw	$t7, 0($a1)
493:	chwrt	
494:	li	$a0, 28
495:	mov	$a1, $s2
496:	li	$a2, 28
497:	sub	$a1, $a1, $a2
498:	chwrt	
499:	lw	$t8, 0($a1)
500:	chwrt	
501:	li	$a0, 29
502:	mov	$a1, $s2
503:	li	$a2, 29
504:	sub	$a1, $a1, $a2
505:	chwrt	
506:	lw	$t9, 0($a1)
507:	chwrt	
508:	li	$a0, 30
509:	mov	$a1, $s2
510:	li	$a2, 30
511:	sub	$a1, $a1, $a2
512:	chwrt	
513:	lw	$sp, 0($a1)
514:	chwrt	
515:	li	$a0, 31
516:	mov	$a1, $s2
517:	li	$a2, 31
518:	sub	$a1, $a1, $a2
519:	chwrt	
520:	lw	$ra, 0($a1)
521:	chwrt	
522:	li	$a0, 99
523:	out	$a0
524:	li	$a0, 123
525:	out	$a0
526:	jr	$ra

circular_queue:
527:	addi	$sp, $sp, 10
528:	sw	$a0, -7($sp)
529:	li	$t0, 0
530:	sw	$t0, -5($sp)
531:	li	$t1, 0
532:	sw	$t1, -4($sp)
533:	li	$t2, 0
534:	sw	$t2, -1($sp)
535:	li	$a0, 4
536:	lcd	$a0
537:	nop	
538:	in	$t3
539:	sw	$t3, 2($gp)
.L3	
540:	lw	$s0, -5($sp)
541:	lw	$s1, -7($sp)
542:	lt	$t4, $s0, $s1
543:	beq	$t4, $rzero, L10
544:	li	$a0, 12
545:	out	$a0
546:	la	$s2, 3($gp)
547:	lw	$s3, -4($sp)
548:	add	$t5, $s2, $s3
549:	lw	$t5, 0($t5)
550:	sw	$t5, -6($sp)
551:	lw	$s4, -6($sp)
552:	sw	$s4, -3($sp)
553:	la	$s5, 43($gp)
554:	lw	$s6, -3($sp)
555:	add	$t6, $s5, $s6
556:	lw	$t6, 0($t6)
557:	li	$t7, 0
558:	eq	$t8, $t6, $t7
559:	beq	$t8, $rzero, L7
560:	mov	$a0, $s6
561:	out	$a0
562:	la	$s7, 33($gp)
563:	add	$t9, $s7, $s6
564:	lw	$t9, 0($t9)
565:	sw	$t9, -1($sp)
566:	lw	$s8, -1($sp)
567:	mov	$a0, $s8
568:	setpc	$a0
569:	mov	$a0, $s6
570:	sw	$ra, -8($sp)
571:	jal	load_proc_context
572:	subi	$sp, $sp, 7
573:	lw	$ra, -8($sp)
574:	mov	$s0, $v0
575:	lw	$s1, -3($sp)
576:	mov	$a0, $s1
577:	nop	
578:	chwrt	
579:	mov	$a0, $a0
580:	chrd	
581:	mov	$s9, $a0
582:	sprc	$s9
583:	nop	
584:	chrd	
585:	chwrt	
586:	nop	
587:	li	$a0, 70
588:	out	$a0
589:	mov	$s2, $v1
590:	sw	$s2, 0($sp)
591:	lw	$s3, 0($sp)
592:	mov	$a0, $s3
593:	out	$a0
594:	getpc	
595:	mov	$s4, $v1
596:	la	$s5, 33($gp)
597:	add	$t0, $s5, $s1
598:	sw	$s4, 0($t0)
599:	li	$t1, 1
600:	eq	$t2, $s3, $t1
601:	beq	$t2, $rzero, L4
602:	mov	$a0, $s3
603:	out	$a0
604:	nop	
605:	in	$t3
606:	sw	$t3, -2($sp)
607:	lw	$s6, -2($sp)
608:	mov	$a0, $s6
609:	out	$a0
610:	mov	$a0, $s6
611:	chwrt	
612:	mov	$v1, $a0
613:	chwrt	
.L4	
614:	lw	$s0, 0($sp)
615:	li	$t4, 2
616:	eq	$t5, $s0, $t4
617:	beq	$t5, $rzero, L5
618:	mov	$a0, $s0
619:	out	$a0
620:	chrd	
621:	mov	$s1, $v1
622:	chrd	
623:	sw	$s1, -2($sp)
624:	lw	$s2, -2($sp)
625:	mov	$a0, $s2
626:	out	$a0
.L5	
627:	lw	$s0, 0($sp)
628:	li	$t6, 3
629:	eq	$t7, $s0, $t6
630:	beq	$t7, $rzero, L6
631:	mov	$a0, $s0
632:	out	$a0
633:	lw	$s1, -3($sp)
634:	mov	$a0, $s1
635:	out	$a0
636:	la	$s2, 43($gp)
637:	add	$t8, $s2, $s1
638:	li	$t9, 1
639:	sw	$t9, 0($t8)
640:	lw	$s3, -5($sp)
641:	addi	$t0, $s3, 1
642:	sw	$t0, -5($sp)
643:	lw	$s3, -5($sp)
.L6	
644:	lw	$s0, -3($sp)
645:	mov	$a0, $s0
646:	sw	$ra, -8($sp)
647:	jal	store_proc_context
648:	subi	$sp, $sp, 4
649:	lw	$ra, -8($sp)
650:	mov	$s0, $v0
.L7	
651:	lw	$s0, -7($sp)
652:	subi	$t1, $s0, 1
653:	lw	$s1, -4($sp)
654:	lt	$t2, $s1, $t1
655:	beq	$t2, $rzero, L8
656:	addi	$t3, $s1, 1
657:	sw	$t3, -4($sp)
658:	lw	$s1, -4($sp)
659:	j	L9
.L8	
660:	li	$t4, 0
661:	sw	$t4, -4($sp)
.L9	
662:	j	L3
.L10	
663:	li	$a0, 5
664:	lcd	$a0
665:	nop	
666:	in	$t5
667:	sw	$t5, 2($gp)
668:	jr	$ra

reset_queue:
669:	addi	$sp, $sp, 3
.L11	
670:	lw	$s0, 0($sp)
671:	li	$t0, 10
672:	lt	$t1, $s0, $t0
673:	beq	$t1, $rzero, L12
674:	la	$s1, 3($gp)
675:	add	$t2, $s1, $s0
676:	li	$t3, 0
677:	sw	$t3, 0($t2)
678:	addi	$t4, $s0, 1
679:	sw	$t4, 0($sp)
680:	lw	$s0, 0($sp)
681:	j	L11
.L12	
682:	li	$a0, 87
683:	out	$a0
684:	jr	$ra

reset_pcs:
685:	addi	$sp, $sp, 3
.L13	
686:	lw	$s0, 0($sp)
687:	li	$t0, 10
688:	lt	$t1, $s0, $t0
689:	beq	$t1, $rzero, L14
690:	la	$s1, 33($gp)
691:	add	$t2, $s1, $s0
692:	li	$t3, 0
693:	sw	$t3, 0($t2)
694:	addi	$t4, $s0, 1
695:	sw	$t4, 0($sp)
696:	lw	$s0, 0($sp)
697:	j	L13
.L14	
698:	li	$a0, 47
699:	out	$a0
700:	jr	$ra

process_handling:
701:	addi	$sp, $sp, 5
702:	li	$a0, 2
703:	lcd	$a0
704:	nop	
705:	in	$t0
706:	sw	$t0, -2($sp)
707:	lw	$s0, -2($sp)
708:	mov	$a0, $s0
709:	out	$a0
710:	li	$t1, 0
711:	sw	$t1, -1($sp)
712:	li	$a0, 3
713:	lcd	$a0
.L15	
714:	lw	$s0, -1($sp)
715:	lw	$s1, -2($sp)
716:	lt	$t2, $s0, $s1
717:	beq	$t2, $rzero, L16
718:	nop	
719:	in	$t3
720:	sw	$t3, 0($sp)
721:	lw	$s2, 0($sp)
722:	mov	$a0, $s2
723:	out	$a0
724:	la	$s3, 3($gp)
725:	add	$t4, $s3, $s0
726:	sw	$s2, 0($t4)
727:	la	$s4, 43($gp)
728:	add	$t5, $s4, $s0
729:	li	$t6, 0
730:	sw	$t6, 0($t5)
731:	addi	$t7, $s0, 1
732:	sw	$t7, -1($sp)
733:	lw	$s0, -1($sp)
734:	j	L15
.L16	
735:	lw	$s0, -2($sp)
736:	mov	$a0, $s0
737:	sw	$ra, -3($sp)
738:	jal	circular_queue
739:	subi	$sp, $sp, 10
740:	lw	$ra, -3($sp)
741:	mov	$s0, $v0
742:	sw	$ra, -3($sp)
743:	jal	reset_queue
744:	subi	$sp, $sp, 3
745:	lw	$ra, -3($sp)
746:	mov	$s0, $v0
747:	sw	$ra, -3($sp)
748:	jal	reset_pcs
749:	subi	$sp, $sp, 3
750:	lw	$ra, -3($sp)
751:	mov	$s0, $v0
752:	jr	$ra

bash:
753:	addi	$sp, $sp, 3
754:	li	$a0, 1
755:	lcd	$a0
756:	nop	
757:	in	$t0
758:	sw	$t0, 0($sp)
759:	lw	$s0, 0($sp)
760:	mov	$a0, $s0
761:	out	$a0
762:	li	$t1, 1
763:	eq	$t2, $s0, $t1
764:	beq	$t2, $rzero, L17
765:	sw	$ra, -1($sp)
766:	jal	process_handling
767:	subi	$sp, $sp, 5
768:	lw	$ra, -1($sp)
769:	mov	$s0, $v0
.L17	
770:	jr	$ra

init_os:
771:	addi	$sp, $sp, 3
772:	li	$t0, 0
773:	sw	$t0, 0($sp)
774:	li	$t1, 10
775:	sw	$t1, 0($gp)
776:	li	$t2, 1024
777:	sw	$t2, 1($gp)
778:	la	$s0, 23($gp)
779:	li	$t3, 50
780:	sw	$t3, 1($s0)
781:	li	$t4, 50
782:	sw	$t4, 2($s0)
783:	li	$t5, 50
784:	sw	$t5, 3($s0)
.L18	
785:	lw	$s0, 0($sp)
786:	li	$t6, 10
787:	lt	$t7, $s0, $t6
788:	beq	$t7, $rzero, L19
789:	la	$s1, 3($gp)
790:	add	$t8, $s1, $s0
791:	li	$t9, 0
792:	sw	$t9, 0($t8)
793:	la	$s2, 43($gp)
794:	add	$t0, $s2, $s0
795:	li	$t1, 0
796:	sw	$t1, 0($t0)
797:	la	$s3, 33($gp)
798:	add	$t2, $s3, $s0
799:	li	$t3, 0
800:	sw	$t3, 0($t2)
801:	la	$s4, 13($gp)
802:	add	$t4, $s4, $s0
803:	sw	$s0, 0($t4)
804:	addi	$t5, $s0, 1
805:	sw	$t5, 0($sp)
806:	lw	$s0, 0($sp)
807:	j	L18
.L19	
808:	jr	$ra

main:
809:	addi	$sp, $gp, 1
810:	addi	$sp, $sp, 54
811:	sw	$ra, 0($sp)
812:	jal	init_os
813:	subi	$sp, $sp, 3
814:	lw	$ra, 0($sp)
815:	mov	$s0, $v0
816:	li	$a0, 0
817:	lcd	$a0
818:	nop	
819:	in	$t0
820:	sw	$t0, 2($gp)
.L20	
821:	li	$t1, 1
822:	li	$t2, 2
823:	lt	$t3, $t1, $t2
824:	beq	$t3, $rzero, L21
825:	sw	$ra, 0($sp)
826:	jal	bash
827:	subi	$sp, $sp, 3
828:	lw	$ra, 0($sp)
829:	mov	$s0, $v0
830:	j	L20
.L21	
831:	subi	$sp, $sp, 1
832:	hlt	
