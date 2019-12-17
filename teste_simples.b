hd[0] <= 32'b011010_00000000000000000010010010; // jump to 146 (main)
hd[1] <= 32'b001100_11110_11110_0000000000000011; // addi: $sp = $sp + (3)
hd[2] <= 32'b010000_11110_00110_0000000000000000; // sw: mem[$sp + (0)] = mem[$a0]
hd[3] <= 32'b001111_00000_00110_0000000001011010; // li: load 90 in register $a0
hd[4] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[5] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[6] <= 32'b001100_11110_11110_0000000000000011; // addi: $sp = $sp + (3)
hd[7] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[8] <= 32'b001111_00000_10100_0000000000001010; // li: load 10 in register $t0
hd[9] <= 32'b110000_01010_10100_10101_00000000000; // lt: if($s0 < $t0): $t1 = 1, else $t1 = 0
hd[10] <= 32'b010001_10101_00000_0000000000010011; // bneq: if($t1 == 0) jump to 19
hd[11] <= 32'b100110_00101_01011_0000000000000010; // la: $s1 = mem[$gp + (2)]
hd[12] <= 32'b000000_01011_01010_10110_00000000000; // add: $t2 = $s1 + $s0
hd[13] <= 32'b001111_00000_10111_0000000000000000; // li: load 0 in register $t3
hd[14] <= 32'b010000_10110_10111_0000000000000000; // sw: mem[$t2 + (0)] = mem[$t3]
hd[15] <= 32'b001100_01010_11000_0000000000000001; // addi: $t4 = $s0 + (1)
hd[16] <= 32'b010000_11110_11000_0000000000000000; // sw: mem[$sp + (0)] = mem[$t4]
hd[17] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[18] <= 32'b011010_00000000000000000000000111; // jump to 7 (L1)
hd[19] <= 32'b001111_00000_00110_0000000001010111; // li: load 87 in register $a0
hd[20] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[21] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[22] <= 32'b001100_11110_11110_0000000000000011; // addi: $sp = $sp + (3)
hd[23] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[24] <= 32'b001111_00000_10100_0000000000001010; // li: load 10 in register $t0
hd[25] <= 32'b110000_01010_10100_10101_00000000000; // lt: if($s0 < $t0): $t1 = 1, else $t1 = 0
hd[26] <= 32'b010001_10101_00000_0000000000100011; // bneq: if($t1 == 0) jump to 35
hd[27] <= 32'b100110_00101_01011_0000000000100000; // la: $s1 = mem[$gp + (32)]
hd[28] <= 32'b000000_01011_01010_10110_00000000000; // add: $t2 = $s1 + $s0
hd[29] <= 32'b001111_00000_10111_0000000000000000; // li: load 0 in register $t3
hd[30] <= 32'b010000_10110_10111_0000000000000000; // sw: mem[$t2 + (0)] = mem[$t3]
hd[31] <= 32'b001100_01010_11000_0000000000000001; // addi: $t4 = $s0 + (1)
hd[32] <= 32'b010000_11110_11000_0000000000000000; // sw: mem[$sp + (0)] = mem[$t4]
hd[33] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[34] <= 32'b011010_00000000000000000000010111; // jump to 23 (L3)
hd[35] <= 32'b001111_00000_00110_0000000000101111; // li: load 47 in register $a0
hd[36] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[37] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[38] <= 32'b001100_11110_11110_0000000000000101; // addi: $sp = $sp + (5)
hd[39] <= 32'b001111_00000_00110_0000000000000010; // li: load 2 in register $a0
hd[40] <= 32'b110110_00000_00110_0000000000000000; // lcd ($a0)
hd[41] <= 32'b011100_00000000000000000000000000; // nop
hd[42] <= 32'b100101_00000_10100_0000000000000000; // in $t0
hd[43] <= 32'b010000_11110_10100_1111111111111110; // sw: mem[$sp + (-2)] = mem[$t0]
hd[44] <= 32'b001110_11110_01010_1111111111111110; // lw: $s0 = mem[$sp] + (-2)
hd[45] <= 32'b011011_01010_00110_0000000000000000; // mov: $a0 = $s0
hd[46] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[47] <= 32'b001111_00000_10101_0000000000000000; // li: load 0 in register $t1
hd[48] <= 32'b010000_11110_10101_1111111111111111; // sw: mem[$sp + (-1)] = mem[$t1]
hd[49] <= 32'b001111_00000_00110_0000000000000011; // li: load 3 in register $a0
hd[50] <= 32'b110110_00000_00110_0000000000000000; // lcd ($a0)
hd[51] <= 32'b001110_11110_01010_1111111111111111; // lw: $s0 = mem[$sp] + (-1)
hd[52] <= 32'b001110_11110_01011_1111111111111110; // lw: $s1 = mem[$sp] + (-2)
hd[53] <= 32'b110000_01010_01011_10110_00000000000; // lt: if($s0 < $s1): $t2 = 1, else $t2 = 0
hd[54] <= 32'b010001_10110_00000_0000000001001000; // bneq: if($t2 == 0) jump to 72
hd[55] <= 32'b011100_00000000000000000000000000; // nop
hd[56] <= 32'b100101_00000_10111_0000000000000000; // in $t3
hd[57] <= 32'b010000_11110_10111_0000000000000000; // sw: mem[$sp + (0)] = mem[$t3]
hd[58] <= 32'b001110_11110_01100_0000000000000000; // lw: $s2 = mem[$sp] + (0)
hd[59] <= 32'b011011_01100_00110_0000000000000000; // mov: $a0 = $s2
hd[60] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[61] <= 32'b100110_00101_01101_0000000000000010; // la: $s3 = mem[$gp + (2)]
hd[62] <= 32'b000000_01101_01010_11000_00000000000; // add: $t4 = $s3 + $s0
hd[63] <= 32'b010000_11000_01100_0000000000000000; // sw: mem[$t4 + (0)] = mem[$s2]
hd[64] <= 32'b100110_00101_01110_0000000000101010; // la: $s4 = mem[$gp + (42)]
hd[65] <= 32'b000000_01110_01010_11001_00000000000; // add: $t5 = $s4 + $s0
hd[66] <= 32'b001111_00000_11010_0000000000000000; // li: load 0 in register $t6
hd[67] <= 32'b010000_11001_11010_0000000000000000; // sw: mem[$t5 + (0)] = mem[$t6]
hd[68] <= 32'b001100_01010_11011_0000000000000001; // addi: $t7 = $s0 + (1)
hd[69] <= 32'b010000_11110_11011_1111111111111111; // sw: mem[$sp + (-1)] = mem[$t7]
hd[70] <= 32'b001110_11110_01010_1111111111111111; // lw: $s0 = mem[$sp] + (-1)
hd[71] <= 32'b011010_00000000000000000000110011; // jump to 51 (L5)
hd[72] <= 32'b001110_11110_01010_1111111111111110; // lw: $s0 = mem[$sp] + (-2)
hd[73] <= 32'b011011_01010_00110_0000000000000000; // mov: $a0 = $s0
hd[74] <= 32'b010000_11110_11111_1111111111111101; // sw: mem[$sp + (-3)] = mem[$ra]
hd[75] <= 32'b100001_00000000000000000000000001; // jump and link to 1 (circular_queue)
hd[76] <= 32'b001101_11110_11110_0000000000000011; // subi: $sp = $sp - (3)
hd[77] <= 32'b001110_11110_11111_1111111111111101; // lw: $ra = mem[$sp] + (-3)
hd[78] <= 32'b011011_00001_01010_0000000000000000; // mov: $s0 = $v0
hd[79] <= 32'b010000_11110_11111_1111111111111101; // sw: mem[$sp + (-3)] = mem[$ra]
hd[80] <= 32'b100001_00000000000000000000000110; // jump and link to 6 (reset_queue)
hd[81] <= 32'b001101_11110_11110_0000000000000011; // subi: $sp = $sp - (3)
hd[82] <= 32'b001110_11110_11111_1111111111111101; // lw: $ra = mem[$sp] + (-3)
hd[83] <= 32'b011011_00001_01010_0000000000000000; // mov: $s0 = $v0
hd[84] <= 32'b010000_11110_11111_1111111111111101; // sw: mem[$sp + (-3)] = mem[$ra]
hd[85] <= 32'b100001_00000000000000000000010110; // jump and link to 22 (reset_pcs)
hd[86] <= 32'b001101_11110_11110_0000000000000011; // subi: $sp = $sp - (3)
hd[87] <= 32'b001110_11110_11111_1111111111111101; // lw: $ra = mem[$sp] + (-3)
hd[88] <= 32'b011011_00001_01010_0000000000000000; // mov: $s0 = $v0
hd[89] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[90] <= 32'b001100_11110_11110_0000000000000011; // addi: $sp = $sp + (3)
hd[91] <= 32'b001111_00000_00110_0000000000000001; // li: load 1 in register $a0
hd[92] <= 32'b110110_00000_00110_0000000000000000; // lcd ($a0)
hd[93] <= 32'b011100_00000000000000000000000000; // nop
hd[94] <= 32'b100101_00000_10100_0000000000000000; // in $t0
hd[95] <= 32'b010000_11110_10100_0000000000000000; // sw: mem[$sp + (0)] = mem[$t0]
hd[96] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[97] <= 32'b011011_01010_00110_0000000000000000; // mov: $a0 = $s0
hd[98] <= 32'b111111_00000_00110_0000000000000000; // out $a0
hd[99] <= 32'b001111_00000_10101_0000000000000001; // li: load 1 in register $t1
hd[100] <= 32'b011110_01010_10101_10110_00000000000; // eq: if($s0 == $t1): $t2 = 1, else $t2 = 0
hd[101] <= 32'b010001_10110_00000_0000000001101011; // bneq: if($t2 == 0) jump to 107
hd[102] <= 32'b010000_11110_11111_1111111111111111; // sw: mem[$sp + (-1)] = mem[$ra]
hd[103] <= 32'b100001_00000000000000000000100110; // jump and link to 38 (process_handling)
hd[104] <= 32'b001101_11110_11110_0000000000000101; // subi: $sp = $sp - (5)
hd[105] <= 32'b001110_11110_11111_1111111111111111; // lw: $ra = mem[$sp] + (-1)
hd[106] <= 32'b011011_00001_01010_0000000000000000; // mov: $s0 = $v0
hd[107] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[108] <= 32'b001100_11110_11110_0000000000000011; // addi: $sp = $sp + (3)
hd[109] <= 32'b001111_00000_10100_0000000000000000; // li: load 0 in register $t0
hd[110] <= 32'b010000_11110_10100_0000000000000000; // sw: mem[$sp + (0)] = mem[$t0]
hd[111] <= 32'b001111_00000_10101_0000000000001010; // li: load 10 in register $t1
hd[112] <= 32'b010000_00101_10101_0000000000000000; // sw: mem[$gp + (0)] = mem[$t1]
hd[113] <= 32'b001111_00000_10110_0000100000110000; // li: load 2096 in register $t2
hd[114] <= 32'b010000_00101_10110_0000000000000001; // sw: mem[$gp + (1)] = mem[$t2]
hd[115] <= 32'b100110_00101_01010_0000000000010110; // la: $s0 = mem[$gp + (22)]
hd[116] <= 32'b001111_00000_10111_0000000000000000; // li: load 0 in register $t3
hd[117] <= 32'b010000_01010_10111_0000000000000001; // sw: mem[$s0 + (1)] = mem[$t3]
hd[118] <= 32'b001111_00000_11000_0000000000000000; // li: load 0 in register $t4
hd[119] <= 32'b010000_01010_11000_0000000000000010; // sw: mem[$s0 + (2)] = mem[$t4]
hd[120] <= 32'b001111_00000_11001_0000000000000000; // li: load 0 in register $t5
hd[121] <= 32'b010000_01010_11001_0000000000000011; // sw: mem[$s0 + (3)] = mem[$t5]
hd[122] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[123] <= 32'b001111_00000_11010_0000000000001010; // li: load 10 in register $t6
hd[124] <= 32'b110000_01010_11010_11011_00000000000; // lt: if($s0 < $t6): $t7 = 1, else $t7 = 0
hd[125] <= 32'b010001_11011_00000_0000000010010001; // bneq: if($t7 == 0) jump to 145
hd[126] <= 32'b100110_00101_01011_0000000000000010; // la: $s1 = mem[$gp + (2)]
hd[127] <= 32'b000000_01011_01010_11100_00000000000; // add: $t8 = $s1 + $s0
hd[128] <= 32'b001111_00000_11101_0000000000000000; // li: load 0 in register $t9
hd[129] <= 32'b010000_11100_11101_0000000000000000; // sw: mem[$t8 + (0)] = mem[$t9]
hd[130] <= 32'b100110_00101_01100_0000000000101010; // la: $s2 = mem[$gp + (42)]
hd[131] <= 32'b000000_01100_01010_10100_00000000000; // add: $t0 = $s2 + $s0
hd[132] <= 32'b001111_00000_10101_0000000000000000; // li: load 0 in register $t1
hd[133] <= 32'b010000_10100_10101_0000000000000000; // sw: mem[$t0 + (0)] = mem[$t1]
hd[134] <= 32'b100110_00101_01101_0000000000100000; // la: $s3 = mem[$gp + (32)]
hd[135] <= 32'b000000_01101_01010_10110_00000000000; // add: $t2 = $s3 + $s0
hd[136] <= 32'b001111_00000_10111_0000000000000000; // li: load 0 in register $t3
hd[137] <= 32'b010000_10110_10111_0000000000000000; // sw: mem[$t2 + (0)] = mem[$t3]
hd[138] <= 32'b100110_00101_01110_0000000000001100; // la: $s4 = mem[$gp + (12)]
hd[139] <= 32'b000000_01110_01010_11000_00000000000; // add: $t4 = $s4 + $s0
hd[140] <= 32'b010000_11000_01010_0000000000000000; // sw: mem[$t4 + (0)] = mem[$s0]
hd[141] <= 32'b001100_01010_11001_0000000000000001; // addi: $t5 = $s0 + (1)
hd[142] <= 32'b010000_11110_11001_0000000000000000; // sw: mem[$sp + (0)] = mem[$t5]
hd[143] <= 32'b001110_11110_01010_0000000000000000; // lw: $s0 = mem[$sp] + (0)
hd[144] <= 32'b011010_00000000000000000001111010; // jump to 122 (L8)
hd[145] <= 32'b011001_11111_00000_00000_00000000000; // jr: jump to register $ra
hd[146] <= 32'b001100_00101_11110_0000000000000001; // addi: $sp = $gp + (1)
hd[147] <= 32'b001100_11110_11110_0000000000110110; // addi: $sp = $sp + (54)
hd[148] <= 32'b001111_00000_00110_0000000000000000; // li: load 0 in register $a0
hd[149] <= 32'b110110_00000_00110_0000000000000000; // lcd ($a0)
hd[150] <= 32'b011100_00000000000000000000000000; // nop
hd[151] <= 32'b100101_00000_10100_0000000000000000; // in $t0
hd[152] <= 32'b010000_00101_10100_0000000000110100; // sw: mem[$gp + (52)] = mem[$t0]
hd[153] <= 32'b001111_00000_10101_0000000000000001; // li: load 1 in register $t1
hd[154] <= 32'b001111_00000_10110_0000000000000010; // li: load 2 in register $t2
hd[155] <= 32'b110000_10101_10110_10111_00000000000; // lt: if($t1 < $t2): $t3 = 1, else $t3 = 0
hd[156] <= 32'b010001_10111_00000_0000000010100011; // bneq: if($t3 == 0) jump to 163
hd[157] <= 32'b010000_11110_11111_0000000000000000; // sw: mem[$sp + (0)] = mem[$ra]
hd[158] <= 32'b100001_00000000000000000001011010; // jump and link to 90 (bash)
hd[159] <= 32'b001101_11110_11110_0000000000000011; // subi: $sp = $sp - (3)
hd[160] <= 32'b001110_11110_11111_0000000000000000; // lw: $ra = mem[$sp] + (0)
hd[161] <= 32'b011011_00001_01010_0000000000000000; // mov: $s0 = $v0
hd[162] <= 32'b011010_00000000000000000010011001; // jump to 153 (L10)
hd[163] <= 32'b001101_11110_11110_0000000000000001; // subi: $sp = $sp - (1)
hd[164] <= 32'b011101_00000000000000000000000000; // hlt
