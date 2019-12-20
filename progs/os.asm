
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
258:	jr	$ra

load_proc_context:
259:	addi	$sp, $sp, 7
260:	sw	$a0, -4($sp)
261:	la	$s0, 23($gp)
262:	lw	$s1, -4($sp)
263:	add	$t0, $s0, $s1
264:	lw	$t0, 0($t0)
265:	sw	$t0, -3($sp)
266:	li	$t1, 0
267:	sw	$t1, -2($sp)
268:	lw	$s2, 1($gp)
269:	mult	$t2, $s2, $s1
270:	sw	$t2, 0($sp)
271:	lw	$s3, 0($sp)
272:	mov	$a0, $s3
273:	out	$a0
.L1	
274:	lw	$s0, -2($sp)
275:	lw	$s1, -3($sp)
276:	lt	$t3, $s0, $s1
277:	beq	$t3, $rzero, L2
278:	lw	$s2, 0($sp)
279:	mov	$a0, $s2
280:	lhd	$t4, $a0
281:	sw	$t4, -1($sp)
282:	lw	$s3, -1($sp)
283:	mov	$a0, $s3
284:	mov	$a1, $s0
285:	smemproc	$a0, $a1
286:	addi	$t5, $s0, 1
287:	sw	$t5, -2($sp)
288:	lw	$s0, -2($sp)
289:	addi	$t6, $s2, 1
290:	sw	$t6, 0($sp)
291:	lw	$s2, 0($sp)
292:	j	L1
.L2	
293:	lw	$s0, -4($sp)
294:	addi	$t7, $s0, 1
295:	sw	$t7, -4($sp)
296:	lw	$s0, -4($sp)
297:	lw	$s1, 1($gp)
298:	mult	$t8, $s0, $s1
299:	sw	$t8, -2($sp)
300:	li	$a0, 1
301:	lw	$s2, -2($sp)
302:	mov	$a1, $s2
303:	li	$a2, 1
304:	sub	$a1, $a1, $a2
305:	chwrt	
306:	lw	$v0, 0($a1)
307:	chwrt	
308:	li	$a0, 2
309:	mov	$a1, $s2
310:	li	$a2, 2
311:	sub	$a1, $a1, $a2
312:	chwrt	
313:	lw	$v1, 0($a1)
314:	chwrt	
315:	li	$a0, 3
316:	mov	$a1, $s2
317:	li	$a2, 3
318:	sub	$a1, $a1, $a2
319:	chwrt	
320:	lw	$out1, 0($a1)
321:	chwrt	
322:	li	$a0, 4
323:	mov	$a1, $s2
324:	li	$a2, 4
325:	sub	$a1, $a1, $a2
326:	chwrt	
327:	lw	$out2, 0($a1)
328:	chwrt	
329:	li	$a0, 5
330:	mov	$a1, $s2
331:	li	$a2, 5
332:	sub	$a1, $a1, $a2
333:	chwrt	
334:	lw	$gp, 0($a1)
335:	chwrt	
336:	li	$a0, 6
337:	mov	$a1, $s2
338:	li	$a2, 6
339:	sub	$a1, $a1, $a2
340:	chwrt	
341:	lw	$a0, 0($a1)
342:	chwrt	
343:	li	$a0, 7
344:	mov	$a1, $s2
345:	li	$a2, 7
346:	sub	$a1, $a1, $a2
347:	chwrt	
348:	lw	$a1, 0($a1)
349:	chwrt	
350:	li	$a0, 8
351:	mov	$a1, $s2
352:	li	$a2, 8
353:	sub	$a1, $a1, $a2
354:	chwrt	
355:	lw	$a2, 0($a1)
356:	chwrt	
357:	li	$a0, 9
358:	mov	$a1, $s2
359:	li	$a2, 9
360:	sub	$a1, $a1, $a2
361:	chwrt	
362:	lw	$a3, 0($a1)
363:	chwrt	
364:	li	$a0, 10
365:	mov	$a1, $s2
366:	li	$a2, 10
367:	sub	$a1, $a1, $a2
368:	chwrt	
369:	lw	$s0, 0($a1)
370:	chwrt	
371:	li	$a0, 11
372:	mov	$a1, $s2
373:	li	$a2, 11
374:	sub	$a1, $a1, $a2
375:	chwrt	
376:	lw	$s1, 0($a1)
377:	chwrt	
378:	li	$a0, 12
379:	mov	$a1, $s2
380:	li	$a2, 12
381:	sub	$a1, $a1, $a2
382:	chwrt	
383:	lw	$s2, 0($a1)
384:	chwrt	
385:	li	$a0, 13
386:	mov	$a1, $s2
387:	li	$a2, 13
388:	sub	$a1, $a1, $a2
389:	chwrt	
390:	lw	$s3, 0($a1)
391:	chwrt	
392:	li	$a0, 14
393:	mov	$a1, $s2
394:	li	$a2, 14
395:	sub	$a1, $a1, $a2
396:	chwrt	
397:	lw	$s4, 0($a1)
398:	chwrt	
399:	li	$a0, 15
400:	mov	$a1, $s2
401:	li	$a2, 15
402:	sub	$a1, $a1, $a2
403:	chwrt	
404:	lw	$s5, 0($a1)
405:	chwrt	
406:	li	$a0, 16
407:	mov	$a1, $s2
408:	li	$a2, 16
409:	sub	$a1, $a1, $a2
410:	chwrt	
411:	lw	$s6, 0($a1)
412:	chwrt	
413:	li	$a0, 17
414:	mov	$a1, $s2
415:	li	$a2, 17
416:	sub	$a1, $a1, $a2
417:	chwrt	
418:	lw	$s7, 0($a1)
419:	chwrt	
420:	li	$a0, 18
421:	mov	$a1, $s2
422:	li	$a2, 18
423:	sub	$a1, $a1, $a2
424:	chwrt	
425:	lw	$s8, 0($a1)
426:	chwrt	
427:	li	$a0, 19
428:	mov	$a1, $s2
429:	li	$a2, 19
430:	sub	$a1, $a1, $a2
431:	chwrt	
432:	lw	$s9, 0($a1)
433:	chwrt	
434:	li	$a0, 20
435:	mov	$a1, $s2
436:	li	$a2, 20
437:	sub	$a1, $a1, $a2
438:	chwrt	
439:	lw	$t0, 0($a1)
440:	chwrt	
441:	li	$a0, 21
442:	mov	$a1, $s2
443:	li	$a2, 21
444:	sub	$a1, $a1, $a2
445:	chwrt	
446:	lw	$t1, 0($a1)
447:	chwrt	
448:	li	$a0, 22
449:	mov	$a1, $s2
450:	li	$a2, 22
451:	sub	$a1, $a1, $a2
452:	chwrt	
453:	lw	$t2, 0($a1)
454:	chwrt	
455:	li	$a0, 23
456:	mov	$a1, $s2
457:	li	$a2, 23
458:	sub	$a1, $a1, $a2
459:	chwrt	
460:	lw	$t3, 0($a1)
461:	chwrt	
462:	li	$a0, 24
463:	mov	$a1, $s2
464:	li	$a2, 24
465:	sub	$a1, $a1, $a2
466:	chwrt	
467:	lw	$t4, 0($a1)
468:	chwrt	
469:	li	$a0, 25
470:	mov	$a1, $s2
471:	li	$a2, 25
472:	sub	$a1, $a1, $a2
473:	chwrt	
474:	lw	$t5, 0($a1)
475:	chwrt	
476:	li	$a0, 26
477:	mov	$a1, $s2
478:	li	$a2, 26
479:	sub	$a1, $a1, $a2
480:	chwrt	
481:	lw	$t6, 0($a1)
482:	chwrt	
483:	li	$a0, 27
484:	mov	$a1, $s2
485:	li	$a2, 27
486:	sub	$a1, $a1, $a2
487:	chwrt	
488:	lw	$t7, 0($a1)
489:	chwrt	
490:	li	$a0, 28
491:	mov	$a1, $s2
492:	li	$a2, 28
493:	sub	$a1, $a1, $a2
494:	chwrt	
495:	lw	$t8, 0($a1)
496:	chwrt	
497:	li	$a0, 29
498:	mov	$a1, $s2
499:	li	$a2, 29
500:	sub	$a1, $a1, $a2
501:	chwrt	
502:	lw	$t9, 0($a1)
503:	chwrt	
504:	li	$a0, 30
505:	mov	$a1, $s2
506:	li	$a2, 30
507:	sub	$a1, $a1, $a2
508:	chwrt	
509:	lw	$sp, 0($a1)
510:	chwrt	
511:	li	$a0, 31
512:	mov	$a1, $s2
513:	li	$a2, 31
514:	sub	$a1, $a1, $a2
515:	chwrt	
516:	lw	$ra, 0($a1)
517:	chwrt	
518:	jr	$ra

circular_queue:
519:	addi	$sp, $sp, 10
520:	sw	$a0, -7($sp)
521:	li	$t0, 0
522:	sw	$t0, -5($sp)
523:	li	$t1, 0
524:	sw	$t1, -4($sp)
525:	li	$t2, 0
526:	sw	$t2, -1($sp)
527:	li	$a0, 4
528:	lcd	$a0
529:	nop	
530:	in	$t3
531:	sw	$t3, 2($gp)
.L3	
532:	lw	$s0, -5($sp)
533:	lw	$s1, -7($sp)
534:	lt	$t4, $s0, $s1
535:	beq	$t4, $rzero, L10
536:	li	$a0, 4
537:	lcd	$a0
538:	nop	
539:	in	$t5
540:	sw	$t5, 2($gp)
541:	la	$s2, 3($gp)
542:	lw	$s3, -4($sp)
543:	add	$t6, $s2, $s3
544:	lw	$t6, 0($t6)
545:	sw	$t6, -6($sp)
546:	lw	$s4, -6($sp)
547:	sw	$s4, -3($sp)
548:	la	$s5, 43($gp)
549:	lw	$s6, -3($sp)
550:	add	$t7, $s5, $s6
551:	lw	$t7, 0($t7)
552:	li	$t8, 0
553:	eq	$t9, $t7, $t8
554:	beq	$t9, $rzero, L7
555:	mov	$a0, $s6
556:	out	$a0
557:	la	$s7, 33($gp)
558:	add	$t0, $s7, $s6
559:	lw	$t0, 0($t0)
560:	sw	$t0, -1($sp)
561:	lw	$s8, -1($sp)
562:	mov	$a0, $s8
563:	setpc	$a0
564:	mov	$a0, $s6
565:	sw	$ra, -8($sp)
566:	jal	load_proc_context
567:	subi	$sp, $sp, 7
568:	lw	$ra, -8($sp)
569:	mov	$s0, $v0
570:	lw	$s1, -3($sp)
571:	mov	$a0, $s1
572:	nop	
573:	chwrt	
574:	mov	$a0, $a0
575:	chrd	
576:	mov	$s9, $a0
577:	sprc	$s9
578:	nop	
579:	chrd	
580:	chwrt	
581:	nop	
582:	mov	$s2, $v1
583:	sw	$s2, 0($sp)
584:	lw	$s3, 0($sp)
585:	mov	$a0, $s3
586:	out	$a0
587:	getpc	
588:	mov	$s4, $v1
589:	la	$s5, 33($gp)
590:	add	$t1, $s5, $s1
591:	sw	$s4, 0($t1)
592:	li	$t2, 1
593:	eq	$t3, $s3, $t2
594:	beq	$t3, $rzero, L4
595:	li	$a0, 12
596:	lcd	$a0
597:	mov	$a0, $s3
598:	out	$a0
599:	nop	
600:	in	$t4
601:	sw	$t4, -2($sp)
602:	lw	$s6, -2($sp)
603:	mov	$a0, $s6
604:	out	$a0
605:	mov	$a0, $s6
606:	chwrt	
607:	mov	$v1, $a0
608:	chwrt	
.L4	
609:	lw	$s0, 0($sp)
610:	li	$t5, 2
611:	eq	$t6, $s0, $t5
612:	beq	$t6, $rzero, L5
613:	li	$a0, 8
614:	lcd	$a0
615:	mov	$a0, $s0
616:	out	$a0
617:	chrd	
618:	mov	$s1, $v1
619:	chrd	
620:	sw	$s1, -2($sp)
621:	lw	$s2, -2($sp)
622:	mov	$a0, $s2
623:	out	$a0
.L5	
624:	lw	$s0, 0($sp)
625:	li	$t7, 3
626:	eq	$t8, $s0, $t7
627:	beq	$t8, $rzero, L6
628:	li	$a0, 9
629:	lcd	$a0
630:	mov	$a0, $s0
631:	out	$a0
632:	lw	$s1, -3($sp)
633:	mov	$a0, $s1
634:	out	$a0
635:	la	$s2, 43($gp)
636:	add	$t9, $s2, $s1
637:	li	$t0, 1
638:	sw	$t0, 0($t9)
639:	lw	$s3, -5($sp)
640:	addi	$t1, $s3, 1
641:	sw	$t1, -5($sp)
642:	lw	$s3, -5($sp)
.L6	
643:	lw	$s0, -3($sp)
644:	mov	$a0, $s0
645:	sw	$ra, -8($sp)
646:	jal	store_proc_context
647:	subi	$sp, $sp, 4
648:	lw	$ra, -8($sp)
649:	mov	$s0, $v0
.L7	
650:	lw	$s0, -7($sp)
651:	subi	$t2, $s0, 1
652:	lw	$s1, -4($sp)
653:	lt	$t3, $s1, $t2
654:	beq	$t3, $rzero, L8
655:	addi	$t4, $s1, 1
656:	sw	$t4, -4($sp)
657:	lw	$s1, -4($sp)
658:	j	L9
.L8	
659:	li	$t5, 0
660:	sw	$t5, -4($sp)
.L9	
661:	j	L3
.L10	
662:	li	$a0, 5
663:	lcd	$a0
664:	nop	
665:	in	$t6
666:	sw	$t6, 2($gp)
667:	jr	$ra

reset_queue:
668:	addi	$sp, $sp, 3
669:	li	$a0, 6
670:	lcd	$a0
671:	nop	
672:	in	$t0
673:	sw	$t0, 2($gp)
.L11	
674:	lw	$s0, 0($sp)
675:	li	$t1, 10
676:	lt	$t2, $s0, $t1
677:	beq	$t2, $rzero, L12
678:	la	$s1, 3($gp)
679:	add	$t3, $s1, $s0
680:	li	$t4, 0
681:	sw	$t4, 0($t3)
682:	addi	$t5, $s0, 1
683:	sw	$t5, 0($sp)
684:	lw	$s0, 0($sp)
685:	j	L11
.L12	
686:	jr	$ra

reset_pcs:
687:	addi	$sp, $sp, 3
688:	li	$a0, 7
689:	lcd	$a0
690:	nop	
691:	in	$t0
692:	sw	$t0, 2($gp)
.L13	
693:	lw	$s0, 0($sp)
694:	li	$t1, 10
695:	lt	$t2, $s0, $t1
696:	beq	$t2, $rzero, L14
697:	la	$s1, 33($gp)
698:	add	$t3, $s1, $s0
699:	li	$t4, 0
700:	sw	$t4, 0($t3)
701:	addi	$t5, $s0, 1
702:	sw	$t5, 0($sp)
703:	lw	$s0, 0($sp)
704:	j	L13
.L14	
705:	jr	$ra

process_handling:
706:	addi	$sp, $sp, 5
707:	li	$a0, 2
708:	lcd	$a0
709:	nop	
710:	in	$t0
711:	sw	$t0, -2($sp)
712:	lw	$s0, -2($sp)
713:	mov	$a0, $s0
714:	out	$a0
715:	li	$t1, 0
716:	sw	$t1, -1($sp)
717:	li	$a0, 3
718:	lcd	$a0
.L15	
719:	lw	$s0, -1($sp)
720:	lw	$s1, -2($sp)
721:	lt	$t2, $s0, $s1
722:	beq	$t2, $rzero, L16
723:	nop	
724:	in	$t3
725:	sw	$t3, 0($sp)
726:	lw	$s2, 0($sp)
727:	mov	$a0, $s2
728:	out	$a0
729:	la	$s3, 3($gp)
730:	add	$t4, $s3, $s0
731:	sw	$s2, 0($t4)
732:	la	$s4, 43($gp)
733:	add	$t5, $s4, $s0
734:	li	$t6, 0
735:	sw	$t6, 0($t5)
736:	addi	$t7, $s0, 1
737:	sw	$t7, -1($sp)
738:	lw	$s0, -1($sp)
739:	j	L15
.L16	
740:	lw	$s0, -2($sp)
741:	mov	$a0, $s0
742:	sw	$ra, -3($sp)
743:	jal	circular_queue
744:	subi	$sp, $sp, 10
745:	lw	$ra, -3($sp)
746:	mov	$s0, $v0
747:	sw	$ra, -3($sp)
748:	jal	reset_queue
749:	subi	$sp, $sp, 3
750:	lw	$ra, -3($sp)
751:	mov	$s0, $v0
752:	sw	$ra, -3($sp)
753:	jal	reset_pcs
754:	subi	$sp, $sp, 3
755:	lw	$ra, -3($sp)
756:	mov	$s0, $v0
757:	jr	$ra

bash:
758:	addi	$sp, $sp, 3
759:	li	$a0, 1
760:	lcd	$a0
761:	nop	
762:	in	$t0
763:	sw	$t0, 0($sp)
764:	lw	$s0, 0($sp)
765:	mov	$a0, $s0
766:	out	$a0
767:	li	$t1, 1
768:	eq	$t2, $s0, $t1
769:	beq	$t2, $rzero, L17
770:	sw	$ra, -1($sp)
771:	jal	process_handling
772:	subi	$sp, $sp, 5
773:	lw	$ra, -1($sp)
774:	mov	$s0, $v0
.L17	
775:	jr	$ra

init_os:
776:	addi	$sp, $sp, 3
777:	li	$t0, 0
778:	sw	$t0, 0($sp)
779:	li	$t1, 10
780:	sw	$t1, 0($gp)
781:	li	$t2, 1024
782:	sw	$t2, 1($gp)
783:	la	$s0, 23($gp)
784:	li	$t3, 50
785:	sw	$t3, 1($s0)
786:	li	$t4, 50
787:	sw	$t4, 2($s0)
788:	li	$t5, 50
789:	sw	$t5, 3($s0)
.L18	
790:	lw	$s0, 0($sp)
791:	li	$t6, 10
792:	lt	$t7, $s0, $t6
793:	beq	$t7, $rzero, L19
794:	la	$s1, 3($gp)
795:	add	$t8, $s1, $s0
796:	li	$t9, 0
797:	sw	$t9, 0($t8)
798:	la	$s2, 43($gp)
799:	add	$t0, $s2, $s0
800:	li	$t1, 0
801:	sw	$t1, 0($t0)
802:	la	$s3, 33($gp)
803:	add	$t2, $s3, $s0
804:	li	$t3, 0
805:	sw	$t3, 0($t2)
806:	la	$s4, 13($gp)
807:	add	$t4, $s4, $s0
808:	sw	$s0, 0($t4)
809:	addi	$t5, $s0, 1
810:	sw	$t5, 0($sp)
811:	lw	$s0, 0($sp)
812:	j	L18
.L19	
813:	jr	$ra

main:
814:	addi	$sp, $gp, 1
815:	addi	$sp, $sp, 54
816:	sw	$ra, 0($sp)
817:	jal	init_os
818:	subi	$sp, $sp, 3
819:	lw	$ra, 0($sp)
820:	mov	$s0, $v0
821:	li	$a0, 0
822:	lcd	$a0
823:	nop	
824:	in	$t0
825:	sw	$t0, 2($gp)
.L20	
826:	li	$t1, 1
827:	li	$t2, 2
828:	lt	$t3, $t1, $t2
829:	beq	$t3, $rzero, L21
830:	sw	$ra, 0($sp)
831:	jal	bash
832:	subi	$sp, $sp, 3
833:	lw	$ra, 0($sp)
834:	mov	$s0, $v0
835:	j	L20
.L21	
836:	subi	$sp, $sp, 1
837:	hlt	
