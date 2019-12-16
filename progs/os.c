/* Global variables declaration */
int MAX_PROCESS; /*maximum number of processes*/
int MEM_SIZE; /*size of memory page*/

int PROCESS_QUEUE[10]; /*the queue for process swapping*/
int FILE_ID[10]; /*stores file ids*/
int FILE_MAX_SIZES[10]; /*stores the maximum size for each file*/
int PROC_PCS[10]; /*store program counters for each proc */
int STATE_PROC[10]; /*stores execution state - 1: finished, 0: ready to be executed*/

int BASH_STOP;

int circular_queue(int amount){
    output(90);
    return;
}

int reset_queue(void){
    int i;

    while(i < 10){
        PROCESS_QUEUE[i] = 0;
        i = i + 1;
    }
    output(87);
    return;
}

int reset_pcs(void){
    int i;

    while(i < 10){
        PROC_PCS[i] = 0;
        i = i + 1;
    }
    output(47);
    return;
}

int process_handling(void){
    int amount;
    int inqueue;
    int proc_ID;

    lcd(2); /*how many files to execute? */
    amount = input();
    output(amount);

    inqueue = 0;
    lcd(3); /*Insert file IDs*/
    while (inqueue < amount){
        proc_ID = input();
        output(proc_ID);
        PROCESS_QUEUE[inqueue] = proc_ID;
        STATE_PROC[inqueue] = 0;
        inqueue = inqueue + 1;
    }

    circular_queue(amount);
    reset_queue();
    reset_pcs();
    return;
}

int bash(void){
    int choice;

    lcd(1); /*make your choice: 1 - process*/
    choice = input();
    output(choice);
    if (choice == 1){
        process_handling();
    }
    return;
}

int init_os(void){
    int i;

    i = 0;
    MAX_PROCESS = 10;
    MEM_SIZE = 2096;

    FILE_MAX_SIZES[1] = 0;
    FILE_MAX_SIZES[2] = 0;
    FILE_MAX_SIZES[3] = 0;

    while (i < 10){
        PROCESS_QUEUE[i] = 0;
        STATE_PROC[i] = 0;
        PROC_PCS[i] = 0;
        FILE_ID[i] = i;
        i = i + 1;
    }    
    return;
}

int main(void){
    
    lcd(0); /*Bem vindx ao sistema operacional*/

    BASH_STOP = input();

    while(1 < 2){
        bash();
    }
}