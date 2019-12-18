int main(void) {
    int index;
    int instruction;

    index = 0;
    instruction = lhd(index);

    while(index != 1024){
        smem(instruction, index);
        index = index + 1;
        instruction = lhd(index);
    }
    smem(instruction, index);
    lcd(8);
    output(index);
    output(99);
}