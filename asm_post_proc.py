import sys

idx_to_nop = None
idx_to_v1 = None

out_idx_to_nop = None
out_idx_to_v1 = None

file_name = str(sys.argv[1])
asm_file =[ line.rstrip('\n') for line in open(file_name) ]
for idx in range(len(asm_file)):
    new_line = asm_file[idx].split()
    if len(new_line) > 1 and new_line[1] == "sysin":
        idx_to_nop = idx + 2
        idx_to_v1 = idx + 3
    elif len(new_line) > 1 and new_line[1] == "sysout":
        out_idx_to_v1 = idx - 2 

print(asm_file[idx_to_nop])
print(asm_file[idx_to_v1])
print(asm_file[out_idx_to_v1])

nop_num = asm_file[idx_to_nop].split()[0]
v1_num = asm_file[idx_to_v1].split()[0]
out_v1_num = asm_file[out_idx_to_v1].split()[0]

with open(f"{file_name[:-4]}_processed.asm", "w") as file:
    for idx in range(len(asm_file)):
        if idx == idx_to_nop:
            file.write(f"{nop_num} nop\n")
        elif idx == idx_to_v1:
            new_line = asm_file[idx_to_v1].split()
            new_line[2] = " $v1,"
            file.write(f"{' '.join(new_line)}\n")
        elif idx == out_idx_to_v1:
            new_line = asm_file[out_idx_to_v1].split()
            new_line[2] = " $v1,"
            file.write(f"{' '.join(new_line)}\n")
        else:
            file.write(f"{''.join(asm_file[idx])}\n")