import sys

label_dict = {}
instruction_types = {
    'add': 'R', 'addi': 'I', 'sub':'R', 'subi':'I', 'mult':'R', 'div':'R', 
    'and':'R', 'or':'R', 'xor':'R', 'not':'R',  
    'get':'R', 'eq':'R', 'gt':'R', 'neq':'R', 'let':'R', 'lt':'R', 'jr':'R',
    'lw':'I', 'li':'I', 'la':'I', 'sw':'I', 'mov':'I',
    'in':'I', 'out':'I', 
    'beq':'I',
    'j':'J', 'jal':'J', 
    'hlt':'I', 'nop':'I',
    # daqui pra baixo tudo eh do so
    'lhd': 'I', 'shd':'I', 'lmem': 'I', 'smem':'I', 'smemproc': 'I',
    'lcd': 'I', 'chwrt':'I', 'chrd':'I', 'setpc':'I', 'getpc':'I', 'sprc':'I',
    'sysin': 'I', 'sysout': 'I', 'sysend':'I'
}

register_bank = {
    '$rzero': "00000", '$v0': "00001", '$v1': "00010", '$out1': "00011", '$out2': "00100",'$gp': "00101", 
    '$a0': "00110",'$a1': "00111", '$a2': "01000",'$a3': "01001",
    '$s0': "01010", '$s1': "01011",'$s2': "01100",'$s3': "01101", '$s4': "01110",
    '$s5': "01111",'$s6': "10000", '$s7': "10001", '$s8': "10010", '$s9': "10011",
    '$t0': "10100", '$t1': "10101", '$t2': "10110",'$t3': "10111",'$t4': "11000", 
    '$t5': "11001", '$t6': "11010", '$t7': "11011",'$t8': "11100", '$t9': "11101",        
    '$sp': "11110", '$ra': "11111"
}


def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def get_zeros(num, field_size):
    number = int(num)
    if number < 0:
        bin_num = bin(number & int("1"*field_size, 2))[2:]
    else:
        bin_num = bin(int(num))[2:]
        for i in range(int(field_size) - len(bin_num)):
            bin_num = '0' + bin_num
    
    return bin_num

def type_R_instruction(instruction):
    name = instruction[1]
    if name == 'add':   #add   $s0, $s1, $s2 -> $s0 = $s1 + $s2
        opcode = '000000'
        print(instruction)
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // add: {rd} = {rs} + {rt}'
        out = bin_inst + comment
    elif name == 'sub': #sub   $s0, $s1, $s2 -> $s0 = $s1 - $s2
        opcode = '000001'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // sub: {rd} = {rs} - {rt}'
        out = bin_inst + comment
    elif name == 'mult': #mul   $s0, $s1, $s2 -> $s0 = $s1 * $s2
        opcode = '000111'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // mul: {rd} = {rs} * {rt}'
        out = bin_inst + comment
    elif name == 'div': #div   $s0, $s1, $s2 -> $s0 = $s1 / $s2
        opcode = '001000'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // div:{rd} = {rs} / {rt}'
        out = bin_inst + comment
    elif name == 'and': #and   $s0, $s1, $s2 -> $s0 = $s1 & $s2
        opcode = '000010'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // and:{rd} = {rs} & {rt}'
        out = bin_inst + comment
    elif name == 'or':  #or   $s0, $s1, $s2 -> $s0 = $s1 | $s2
        opcode = '000011'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // or: {rd} = {rs} | {rt}'
        out = bin_inst + comment
    elif name == 'xor':  #xor $s0 $s1 $s2 -> $s0 = $s1 ^ $s2
        opcode = '001011'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // xor: {rd} = {rs} ^ {rt}'
        out = bin_inst + comment
    elif name == 'not': #not $s0 $s1 -> $s0 = !$s1
        opcode = '000100'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '00000000000'
        sparereg ='00000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{sparereg}_{spare};'
        comment = f' // not: {rd} != {rs}'
        out = bin_inst + comment
    elif name == 'get': #get $t4, $t3, $s3 -> if($t3 >= $s3): $t4 = 1, else $t4 = 0
        opcode = '010111'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // get: if({rs} >= {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'gt': #gt $t4, $t3, $s3 -> if($t3 > $s3): $t4 = 1, else $t4 = 0
        opcode = '100000'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // gt: if({rs} > {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'eq':  #eq $t4, $t3, $s3 -> if($t3 == $s3): $t4 = 1, else $t4 = 0
        opcode = '011110'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // eq: if({rs} == {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'neq': #neq $t4, $t3, $s3 -> if($t3 != $s3): $t4 = 1, else $t4 = 0
        opcode = '100010'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // neq: if({rs} != {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'let': #let $t4, $t3, $s3 -> if($t3 <= $s3): $t4 = 1, else $t4 = 0
        opcode = '110001'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // let: if({rs} <= {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'lt':  #lt $t4, $t3, $s3 -> if($t3 < $s3): $t4 = 1, else $t4 = 0
        opcode = '110000'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        rt = instruction[4].replace(',','')
        spare = '00000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rt]}_{register_bank[rd]}_{spare};'
        comment = f' // lt: if({rs} < {rt}): {rd} = 1, else {rd} = 0'
        out = bin_inst + comment
    elif name == 'jr': #jr $ra
        opcode = '011001'
        ra = instruction[2]
        spare = '00000000000'
        sparereg = '00000'
        bin_inst = f'32\'b{opcode}_{register_bank[ra]}_{sparereg}_{sparereg}_{spare};' 
        comment = f' // jr: jump to register {ra}'
        out = bin_inst + comment
    return out


def type_I_instruction(instruction):
    name = instruction[1]
    if name == 'addi': # addi    $sp, $sp, 3 -> $sp = $sp + 3
        opcode = '001100'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        int_immediate = instruction[4].replace(',','')
        immediate = get_zeros(int_immediate, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{immediate};'
        comment = f' // addi: {rd} = {rs} + ({int_immediate})'
        out = bin_inst + comment
    elif name =='subi': # subi    $sp, $sp, 3 -> $sp = $sp - 3
        opcode = '001101'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        int_immediate = instruction[4].replace(',','')
        immediate = get_zeros(int_immediate, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{immediate};'
        comment = f' // subi: {rd} = {rs} - ({int_immediate})'
        out = bin_inst + comment
    elif name == 'lw': # lw  $s0, 0($sp) -> $s0 = mem[$sp + 0]
        opcode = '001110'
        rs = instruction[2].replace(',','')
        int_offset, rd = instruction[3].split('(')
        rd = rd.replace(')', '')
        offset = get_zeros(int_offset, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rd]}_{register_bank[rs]}_{offset};'
        comment = f' // lw: {rs} = mem[{rd}] + ({int_offset})'
        out = bin_inst + comment
    elif name == 'sw': # sw  $t3, 0($sp) -> mem[$sp + 0] = $t3
        opcode = '010000'
        rs = instruction[2].replace(',','')
        int_offset, rd = instruction[3].split('(')
        rd = rd.replace(')', '')
        offset = get_zeros(int_offset, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rd]}_{register_bank[rs]}_{offset};'
        comment = f' // sw: mem[{rd} + ({int_offset})] = mem[{rs}]'
        out = bin_inst + comment
    elif name == 'li':  # li $t0, 0 -> $t0 = 0
        opcode = '001111'
        rs = instruction[2].replace(',','')
        sparereg = '00000'
        int_offset = instruction[3]
        offset = get_zeros(int_offset, 16)
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{offset};'
        comment = f' // li: load {int_offset} in register {rs}'
        out = bin_inst + comment
    elif name == 'la': # la $a0, -9($gp) -> $a0 = mem[$gp - 9]
        opcode = '100110'
        rs = instruction[2].replace(',','')
        int_offset, rd = instruction[3].split('(')
        rd = rd.replace(')', '')
        offset = get_zeros(int_offset, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rd]}_{register_bank[rs]}_{offset};'
        comment = f' // la: {rs} = mem[{rd} + ({int_offset})]'
        out = bin_inst + comment
    elif name == 'mov': # mov   $s0, $v0 -> $s0 = $v0
        opcode = '011011'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // mov: {rd} = {rs}'
        out = bin_inst + comment
    elif name == 'beq': # beq   $t2, $rzero, L7 -> if($t2 == 0) jump to L7
        opcode = '010001'
        rd = instruction[2].replace(',','')
        rzero = instruction[3].replace(',','')
        line_num = label_dict[instruction[-1]]
        bin_line_num = get_zeros(line_num, 16)
        bin_inst = f'32\'b{opcode}_{register_bank[rd]}_{register_bank[rzero]}_{bin_line_num};'
        comment = f' // bneq: if({rd} == 0) jump to {line_num}'
        out = bin_inst + comment
    elif name == 'in':  # in    $t3
        opcode = '100101'
        rs = instruction[2]
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{spare};'
        comment = f' // in {rs}'
        out = bin_inst + comment
    elif name == 'out': #out    $a0
        opcode = '111111'
        sparereg = '00000'
        spare = '0000000000000000'
        rs = instruction[2]
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{spare};'
        comment = f' // out {rs}'
        out = bin_inst + comment
    elif name == 'hlt':
        opcode = '011101'
        spare = '00000000000000000000000000'
        bin_inst = f'32\'b{opcode}_{spare};'
        comment = f' // hlt'
        out = bin_inst + comment
    elif name == 'nop':
        opcode = '011100'
        spare = '00000000000000000000000000'
        bin_inst = f'32\'b{opcode}_{spare};'
        comment = f' // nop'
        out = bin_inst + comment
        ############################ additions ############################
    elif name == 'lhd':
        opcode = '110010'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // lhd: {rd} = hd[{rs}]'
        out = bin_inst + comment
        out = bin_inst + comment
    elif name == 'shd':
        opcode = '110011'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // shd: {rd} = {rs}'
        out = bin_inst + comment
    elif name == 'lmem':
        opcode = '110100'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // lmem: {rd} = {rs}'
        out = bin_inst + comment
    elif name == 'smem':
        opcode = '110101'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // smem: mem[{rd}] = {rs}'
        out = bin_inst + comment
    elif name == 'smemproc':
        opcode = '110111'
        rd = instruction[2].replace(',','')
        rs = instruction[3].replace(',','')
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{register_bank[rs]}_{register_bank[rd]}_{spare};'
        comment = f' // smem_proc: mem[{rd}] = {rs}'
        out = bin_inst + comment
    elif name == 'lcd': #out    $a0
        opcode = '110110'
        sparereg = '00000'
        spare = '0000000000000000'
        rs = instruction[2]
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{spare};'
        comment = f' // lcd ({rs})'
        out = bin_inst + comment
    elif name == 'chwrt': #chwrt 
        opcode = '111000'
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{sparereg}_{spare};'
        comment = f' // chrt'
        out = bin_inst + comment
    elif name == 'chrd': #chrd
        opcode = '111001'
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{sparereg}_{spare};'
        comment = f' // chrd'
        out = bin_inst + comment
    elif name == 'setpc': #setpc $aX
        opcode = '111110'
        rs = instruction[2].replace(',','')
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{spare};'
        comment = f' // process pc = {rs} '
        out = bin_inst + comment
    elif name == 'getpc': #getpc
        opcode = '111101'
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{sparereg}_{spare};'
        comment = f' // $v1 = process pc'
        out = bin_inst + comment
    elif name == 'sprc': #sprc
        opcode = '100111'
        rs = instruction[2].replace(',','')
        sparereg = '00000'
        spare = '0000000000000000'
        bin_inst = f'32\'b{opcode}_{sparereg}_{register_bank[rs]}_{spare};'
        comment = f' // sprc = {rs} '
        out = bin_inst + comment
    elif name == 'sysin':
        opcode = '111010'
        spare = '00000000000000000000000000'
        bin_inst = f'32\'b{opcode}_{spare};'
        comment = f' // sysin'
        out = bin_inst + comment
    elif name == 'sysout':
        opcode = '111011'
        spare = '00000000000000000000000000'
        bin_inst = f'32\'b{opcode}_{spare};'
        comment = f' // sysout'
        out = bin_inst + comment
    elif name == 'sysend':
        opcode = '111100'
        spare = '00000000000000000000000000'
        bin_inst = f'32\'b{opcode}_{spare};'
        comment = f' // sysend'
        out = bin_inst + comment
    return out

def type_J_instruction(instruction):
    name = instruction[1]
    if name == 'j': #j L1
        opcode = '011010'
        line_num = label_dict[instruction[-1]]
        bin_line_num = get_zeros(line_num, 26)
        #bin_inst = '32\'b' + opcode + '_' + bin_line_num + ';'
        bin_inst = f'32\'b{opcode}_{bin_line_num};'
        comment =  f' // jump to {line_num} ({instruction[-1]})'
        out = bin_inst + comment
    elif name == 'jal': #jal fatorial
        opcode = '100001'
        line_num = label_dict[instruction[-1]]
        bin_line_num = get_zeros(line_num, 26)
        bin_inst = f'32\'b{opcode}_{bin_line_num};'
        comment =  f' // jump and link to {line_num} ({instruction[-1]})'
        out = bin_inst + comment
    
    return out 

def main():

    file_name = str(sys.argv[3])

    instruction_number = 1
    asm_file =[ line.rstrip('\n') for line in open(file_name) ]
    for line in asm_file:
        instruction = line.split()
        if len(instruction) > 0:
            #print(instruction)
            instruction_name =  instruction[0] 
            instruction_name = instruction_name.replace(':', '').replace('.', '')
            if not instruction_name.isdigit():
                label_dict[instruction_name] = instruction_number
                #print(instruction_name)
            else:
                instruction_number += 1

    mem_name = str(sys.argv[1])
    instr_num = int(sys.argv[2])
    

    out_file = open('teste_simples.b', 'w')
    instruction_number = instr_num + 1
    out = mem_name + '[' + str(instr_num) + '] <= ' + type_J_instruction(['0:','j','main']) + '\n'
    out_file.write(out)
    for line in asm_file:
        instruction = line.split()
        if len(instruction) > 0:
            instruction_name =  instruction[0]
            instruction_name = instruction_name.replace(':', '').replace('.', '')
            if instruction_name.isdigit():
                instructionzera = instruction[1]
                if instructionzera in instruction_types:
                    instruction_type = instruction_types[instructionzera]
                    if instruction_type == 'R':
                        out = type_R_instruction(instruction)
                    elif instruction_type == 'I':
                        out = type_I_instruction(instruction)
                    elif instruction_type == 'J':
                        out = type_J_instruction(instruction)
                    out_bin = f'{mem_name}[{instruction_number}] <= {out}\n'
                    #print(out_bin)
                    out_file.write(out_bin)
                    instruction_number += 1
            else:
                continue
    out_file.close()


if __name__ == '__main__':
    main()


