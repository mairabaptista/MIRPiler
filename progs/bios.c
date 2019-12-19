int main(void) {
    int index;
    int instruction;

    index = 0;

    while(index != 1024){
        instruction = lhd(index);
        smem(instruction, index);
        index = index + 1;
    }
    
    lcd(8);
    output(index);
    output(99);
}