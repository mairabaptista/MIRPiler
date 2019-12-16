def insert_beg(instruction, instruction_number):
    return instruction[:0] + str(instruction_number)+ ' : ' + instruction[0:]

def main():
    instruction_number = 0
    binary_file =[ line.rstrip('\n') for line in open('teste_simples.b') ]
    out_file = open('tomemrom.txt', 'w')
    for line in binary_file:

        instruction = line.split()
        bin_inst = instruction[2]
        bin_inst = bin_inst.replace('32\'b', '').replace('_', '')
        bin_inst = insert_beg(bin_inst, instruction_number)
        bin_inst = bin_inst + '\n'
        out_file.write(bin_inst)
        instruction_number += 1

    out_file.close()
    '''
    out_file = open('tomemrom.txt', 'w')
    instruction_number = 1
    out = 'ROM[0] <= ' + type_J_instruction(['0:','j','main']) + '\n'
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
                    out_bin = f'ROM[{instruction_number}] <= {out}\n'
                    #print(out_bin)
                    out_file.write(out_bin)
                    instruction_number += 1
            else:
                continue
    out_file.close()
    '''

if __name__ == '__main__':
    main()