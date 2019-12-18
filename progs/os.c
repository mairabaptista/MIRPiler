/* Global variables declaration */
int MAX_PROCESS; /*maximum number of processes*/
int MEM_SIZE; /*size of memory page*/

int PROCESS_QUEUE[10]; /*the queue for process swapping*/
int FILE_ID[10]; /*stores file ids*/
int FILE_MAX_SIZES[10]; /*stores the maximum size for each file*/
int PROC_PCS[10]; /*store program counters for each proc */
int STATE_PROC[10]; /*stores execution state - 1: finished, 0: ready to be executed*/

int BASH_STOP;

int INTERRUPTION;

/*void load_proc_context(int proc_index){
    int transfer_iterations;
    int transfer_index;
    int instruction;
    int hd_address;


    output(89);
    transfer_iterations = FILE_MAX_SIZES[proc_index];
    transfer_index = 0;
    hd_address = MEM_SIZE * proc_index;
    instruction = lhd(hd_address);

    while( transfer_index < transfer_iterations ) {
        smemproc(instruction, transfer_index);
        transfer_index = transfer_index + 1;
        hd_address= hd_address + 1;
        instruction = lhd(hd_address);
    }
    smemproc(instruction, transfer_index);

    output(99);

    return;
}
*/

void circular_queue(int amount){
    
    int proc_ID;
    int finished_procs;
    int queue_index;
    int proc_index;
    int io_aux;
    int proc_pc;

    finished_procs = 0;
    queue_index = 0;
    proc_pc = 0;

    lcd(4); 

    BASH_STOP = input();

    while (finished_procs < amount){
        output(12);
        output(13);
        /*proc_ID = PROCESS_QUEUE[queue_index];
        proc_index = proc_ID; 
        if( STATE_PROC[proc_index] == 0 ) {
            output( proc_index );
            proc_pc = PROC_PCS[proc_index];
            set_proc_pc( proc_pc );
            
            swap_process(proc_index);
            recover_os();
            output(70);
            INTERRUPTION = get_interruption();
            output(INTERRUPTION);
            PROC_PCS[proc_index] = get_proc_pc();
            
            if( INTERRUPTION == 1 ) {
                output(INTERRUPTION);
                io_aux = input();
                output(io_aux);
                move_OS_to_proc(io_aux); 
            }
            
            if(INTERRUPTION == 2) {
                output(INTERRUPTION);
                io_aux = move_proc_to_OS(); 
                output(io_aux);
            }
            
            if(INTERRUPTION == 3) {
                output(INTERRUPTION);
                output(proc_index);
                STATE_PROC[proc_index] = 1;
                finished_procs = finished_procs + 1;
            }
            
        }
        
        if(queue_index < amount - 1) {             
            queue_index = queue_index + 1;
        }
        else {
            queue_index = 0;
        }*/
    }
    lcd(5); 
    BASH_STOP = input();

    return;
}

void reset_queue(void){
    int i;

    while(i < 10){
        PROCESS_QUEUE[i] = 0;
        i = i + 1;
    }
    output(87);
    return;
}

void reset_pcs(void){
    int i;

    while(i < 10){
        PROC_PCS[i] = 0;
        i = i + 1;
    }
    output(47);
    return;
}

void process_handling(void){
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

void bash(void){
    int choice;

    lcd(1); /*make your choice: 1 - process*/
    choice = input();
    output(choice);
    if (choice == 1){
        process_handling();
    }
    return;
}

void init_os(void){
    int i;

    i = 0;
    MAX_PROCESS = 10;
    MEM_SIZE = 1024;

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