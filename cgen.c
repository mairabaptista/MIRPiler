/****************************************************/
/* File: cgen.c                                     */
/* The code generator implementation                */
/* for the TINY compiler                            */
/* (generates code for the TM machine)              */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "symtab.h"
#include "cgen.h"
#include "util.h"

#define PROGRAMA 1
#define KERNEL 0

//Head of quadruple list
Quadruple head = NULL;

//top of location stack
LocationStack locationHead = NULL;

//number of arguments in function call
ParamStack paramHead = NULL;

Operand currentOperand;

InstructionKind currentInstruction;

////when to return array address
Quadruple lastQuadruple;

static int temporary = 1;
static int label = 1;
static int line = 0;
static char tempString[20];


static void cGen (TreeNode * tree, CodeType codeInfo);

static char * createTemporaryOperandName() {
    char * temp = (char *) malloc(5);
    sprintf(temp, "T%d", temporary);
    ++temporary;
    return temp;
}

/* Procedure genStmt generates code at a statement node */
static void genStmt(TreeNode * tree, CodeType codeInfo) {
    
    Quadruple * q;

    Quadruple quadIf = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadEndIf = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadEndIf2 = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadElse = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadIteration = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadIteration2 = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadIteration3 = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadIteration4 = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadReturn = (Quadruple) malloc(sizeof(struct Quad));

    Operand op1, op2, op3;
    TreeNode * p1, * p2, * p3;
    p1 = tree->child[0];
    p2 = tree->child[1];
    p3 = tree->child[2];

    switch (tree->kind.stmt) {
        case If:  //IF OPAREN expression CPAREN statement 
            //generates expression
            cGen(p1, codeInfo);
            //sets as first operand
            op1 = currentOperand;

            currentInstruction = JFALSE;
            //new quadruple entry
            quadIf->instruction = JFALSE;
            quadIf->op1 = op1;
            quadIf->op2 = NULL;
            quadIf->op3 = NULL;
            quadIf->line = ++line;
            quadIf->next = NULL;
            q = insertQuad(quadIf);
            //saves location to the end of if block
            LocationStack locale = (LocationStack) malloc(sizeof(struct Location));
            locale->quad = q;
            locale->next = NULL;
            if(locationHead == NULL){
                locationHead = locale;
                locationHead->next = NULL;
            }
            else{
                locale->next = locationHead;
                locationHead = locale;
            }
            //generates statement
            cGen(p2, codeInfo);
            //set second operand
            op2 = (Operand) malloc(sizeof(struct operand));
            op2->kind = String;

            //create label
            char *auxlabel = (char *) malloc(5);
            auxlabel = itoa(label, auxlabel, 10);
            char * L = (char *) malloc(strlen(auxlabel) + 1);
            strcpy(L, "L");
            strcat(L, auxlabel);
            op2->contents.variable.name = L;
            label++;
            
            op2->contents.variable.scope = tree->kind.decl.scope;
            //updates locaion
            Quadruple aux = *locationHead->quad;
            aux->op2 = op2;
            *locationHead->quad = aux;

            //frees location stack
            if(locationHead != NULL){
                LocationStack aux = locationHead;
                locationHead = locationHead->next;
                free(aux);
                aux = NULL;
            }

            if(p3 != NULL) { 
                //if not null, we have else
                //we then need a goto to the end of the if block
                //new qaudruple entry
                quadElse->instruction = GOTO;
                quadElse->op1 = NULL;
                quadElse->op2 = NULL;
                quadElse->op3 = NULL;
                quadElse->line = ++line;
                quadElse->next = NULL;
                q = insertQuad(quadElse);

                //saves location to the ed of if block
                LocationStack locale = (LocationStack) malloc(sizeof(struct Location));
                locale->quad = q;
                locale->next = NULL;
                if(locationHead == NULL){
                    locationHead = locale;
                    locationHead->next = NULL;
                }
                else{
                    locale->next = locationHead;
                    locationHead = locale;
                }
            }

            //labels the end of if block
            quadEndIf->instruction = LBL;
            quadEndIf->op1 = op2;
            quadEndIf->op2 = NULL;
            quadEndIf->op3 = NULL;
            quadEndIf->line = ++line;
            quadEndIf->next = NULL;
            insertQuad(quadEndIf);

            cGen(p3, codeInfo);

            if(p3 != NULL) { //IF OPAREN expression CPAREN statement ELSE statement
                op1 = (Operand) malloc(sizeof(struct operand));
                op1->kind = String;
                //create label
                char *auxlabel2 = (char *) malloc(5);
                auxlabel2 = itoa(label, auxlabel2, 10);
                char * L2 = (char *) malloc(strlen(auxlabel2) + 1);
                strcpy(L2, "L");
                strcat(L2, auxlabel2);
                op1->contents.variable.name = L2;
                label++;

                op1->contents.variable.scope = tree->kind.decl.scope;
                //updates location
                Quadruple aux = *locationHead->quad;
                aux->op1 = op1;
                *locationHead->quad = aux;
                //frees location
                if(locationHead != NULL){
                    LocationStack aux = locationHead;
                    locationHead = locationHead->next;
                    free(aux);
                    aux = NULL;
                }

                //labels the end of else block
                quadEndIf2->instruction = LBL;
                quadEndIf2->op1 = op1;
                quadEndIf2->op2 = NULL;
                quadEndIf2->op3 = NULL;
                quadEndIf2->line = ++line;
                quadEndIf2->next = NULL;
                insertQuad(quadEndIf2);
            }
            break; 

        case Iteration: //WHILE OPAREN expression CPAREN statement 
            op1 = (Operand) malloc(sizeof(struct operand));
            op1->kind = String;
            //create label
            char *auxlabel3 = (char *) malloc(5);
            auxlabel3 = itoa(label, auxlabel3, 10);
            char * L3 = (char *) malloc(strlen(auxlabel3) + 1);
            strcpy(L3, "L");
            strcat(L3, auxlabel3);
            op1->contents.variable.name = L3;
            label++;
            
            op1->contents.variable.scope = tree->kind.decl.scope;
            //sets a label to the beginning of the while block            
            quadIteration->instruction = LBL;
            quadIteration->op1 = op1;
            quadIteration->op2 = NULL;
            quadIteration->op3 = NULL;
            quadIteration->line = ++line;
            quadIteration->next = NULL;
            insertQuad(quadIteration);

            //generates expression
            cGen(p1, codeInfo);
            // set as first operand 
            op2 = currentOperand;

            currentInstruction = JFALSE;
            //new quadruple entry
            quadIteration2->instruction = JFALSE;
            quadIteration2->op1 = op2;
            quadIteration2->op2 = NULL;
            quadIteration2->op3 = NULL;
            quadIteration2->line = ++line;
            quadIteration2->next = NULL;
            q = insertQuad(quadIteration2);

            //saves location to update the label that represents end of while
            LocationStack locale2 = (LocationStack) malloc(sizeof(struct Location));
            locale2->quad = q;
            locale2->next = NULL;
            if(locationHead == NULL){
                locationHead = locale2;
                locationHead->next = NULL;
            }
            else{
                locale->next = locationHead;
                locationHead = locale2;
            }

            //generates statement
            cGen(p2, codeInfo);
            currentInstruction = GOTO;
            //we need a goto to go back to the beginning of the while
            quadIteration3->instruction = GOTO;
            quadIteration3->op1 = op1;
            quadIteration3->op2 = NULL;
            quadIteration3->op3 = NULL;
            quadIteration3->line = ++line;
            quadIteration3->next = NULL;
            insertQuad(quadIteration3);

            op3 = (Operand) malloc(sizeof(struct operand));
            op3->kind = String;
            //create label
            char *auxlabel4 = (char *) malloc(5);
            auxlabel4 = itoa(label, auxlabel4, 10);
            char * L4 = (char *) malloc(strlen(auxlabel4) + 1);
            strcpy(L4, "L");
            strcat(L4, auxlabel4);
            op3->contents.variable.name = L4;
            label++;

            op3->contents.variable.scope = tree->kind.decl.scope;
            //we create a label to jump to if while condition is false
            quadIteration4->instruction = LBL;
            quadIteration4->op1 = op3;
            quadIteration4->op2 = NULL;
            quadIteration4->op3 = NULL;
            quadIteration4->line = ++line;
            quadIteration4->next = NULL;
            insertQuad(quadIteration4);

            //updates location
            Quadruple aux2 = *locationHead->quad;
            aux2->op2 = op3;
            *locationHead->quad = aux2;
            
            //frees location          
            if(locationHead != NULL){
                LocationStack aux2 = locationHead;
                locationHead = locationHead->next;
                free(aux2);
                aux2 = NULL;
            }
            break; 

        case Return:  // RETURN SEMI | RETURN expression SEMI
            //generates expression
            cGen(p1, codeInfo);
            if(p1) {
                //sets as first operand
                op1 = currentOperand;
            } else {
                op1 = NULL;
            }
            
            currentInstruction = RTN;
            //new quadruple representation
            quadReturn->instruction = RTN;
            quadReturn->op1 = op1;
            quadReturn->op2 = NULL;
            quadReturn->op3 = NULL;
            quadReturn->line = ++line;
            quadReturn->next = NULL;
            insertQuad(quadReturn);
            break; 

            case Compound: //OCURLY local_declarations statement_list CCURLY
            if(p1) { 
                //generates local_declarations
                cGen(p1, codeInfo);
            }
            if(p2) { 
                //generates statement_list
                cGen(p2, codeInfo);
            }
            break; 

            case Integer:
            cGen(p1, codeInfo);
            break; 

        case Void:
            cGen(p1, codeInfo);
            break; 
    }
} /* genStmt */

/* Procedure genExp generates code at an expression node */
static void genExp(TreeNode * tree, CodeType codeInfo) {
    TreeNode * p1, * p2;
    Operand op1, op2, op3;

    p1 = tree->child[0];
    p2 = tree->child[1];

    Quadruple quadAssign = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadRelop = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadArtith = (Quadruple) malloc(sizeof(struct Quad));

    switch (tree->kind.exp) {
        case Assign: //var assigment_operator expression
            //generates expression
            cGen(p2, codeInfo);
            //sets as second operand
            op2 = currentOperand;
            //generats var
            cGen(p1, codeInfo);
            //sets as first oprand
            op1 = currentOperand;
            op3 = NULL;

            //if we`re assigning an array, we store the variable`s memory position
            if(p1->nodekind == Decl && p1->kind.decl.declkind == Array) {
                lastQuadruple->instruction = VEC_ADDR;
                //if index is a number, add offset as third operand
                if(lastQuadruple->op2->kind == IntConst) {
                    op3 = (Operand) malloc(sizeof(struct operand));
                    op3->kind = IntConst;
                    op3->contents.val = lastQuadruple->op2->contents.val;
                    op1 = lastQuadruple->op1;
                }
            }

            
            currentInstruction = ASN;
            //new quadruple entry
            quadAssign->instruction = ASN;
            quadAssign->op1 = op1;
            quadAssign->op2 = op2;
            quadAssign->op3 = op3;
            quadAssign->line = ++line;
            quadAssign->next = NULL;
            insertQuad(quadAssign);
            break; 

        case Relop: //additive_expression relop additive_expression
            //generates additive_expression
            cGen(p1, codeInfo);
            //sets as first operand
            op1 = currentOperand;
            //generates additive_expression
            cGen(p2, codeInfo);
            //sets as second operand
            op2 = currentOperand;
            switch (tree->op) { //chooses instrucion type
                case EQ:
                    currentInstruction = EQUAL;
                    break;
                case NEQ:
                    currentInstruction = NE;
                    break;
                case LT:
                    currentInstruction = LST;
                    break;
                case LE:
                    currentInstruction = LET;
                    break;
                case GT:
                    currentInstruction = GRT;
                    break;
                case GE:
                    currentInstruction = GET;
                    break;
            }
            //wee need a temporary for this operation
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = String;
            currentOperand->contents.variable.scope = NULL;
            currentOperand->contents.variable.name = createTemporaryOperandName();

            //new quadruple entry
            quadRelop->instruction = currentInstruction;
            quadRelop->op1 = op1;
            quadRelop->op2 = op2;
            quadRelop->op3 = currentOperand;
            quadRelop->line = ++line;
            quadRelop->next = NULL;
            insertQuad(quadRelop);
            break; 

        case Arith:
            //generates additive_expression
            cGen(p1, codeInfo);
            //sets as first operand
            op1 = currentOperand;
            //generates term
            cGen(p2, codeInfo);
            //sets as second operand
            op2 = currentOperand;
            switch (tree->op) {    //chooses instruction type
                case PLUS:
                    currentInstruction = ADD;
                    break;
                case MINUS:
                    currentInstruction = SUB;
                    break;
                case MULT:
                    currentInstruction = TIMES;
                    break;
                case DIV:
                    currentInstruction = OVER;
                    break;
            }
            //we need a temporary for this operaion
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = String;
            currentOperand->contents.variable.scope = NULL;
            currentOperand->contents.variable.name = createTemporaryOperandName();
            //new quadruple entry
            quadArtith->instruction = currentInstruction;
            quadArtith->op1 = op1;
            quadArtith->op2 = op2;
            quadArtith->op3 = currentOperand;
            quadArtith->line = ++line;
            quadArtith->next = NULL;
            insertQuad(quadArtith);
            break; 
    }
} /* genExp */

static void genVar(TreeNode * tree, CodeType codeInfo) {
    Quadruple q;
    TreeNode * p1, * p2;
    Operand op1, op2, op3;

    p1 = tree->child[0];
    p2 = tree->child[1];

    Quadruple quadArray = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadFunction = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadParam = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadCall = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadCall2 = (Quadruple) malloc(sizeof(struct Quad));
    Quadruple quadCall3 = (Quadruple) malloc(sizeof(struct Quad));

    int qtdParams = -1;
    int offset = -1;
    int display = -1;

    /*if((strcmp(tree->kind.decl.name, "input") == 0) && (codeInfo == PROGRAMA)){
        //
    }*/

    switch (tree->kind.decl.declkind) {
        case Const: //NUM
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = IntConst;
            currentOperand->contents.val = tree->kind.decl.value;
            break;

        case Id: //ID
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = String;
            currentOperand->contents.variable.name = tree->kind.decl.name;
            currentOperand->contents.variable.scope = tree->kind.decl.scope;
            break; 
        case Array: //id OBRACKET expression CBRACKET
            p1 = tree->child[0];
            //currentoperand is now array id, sets as op1
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = String;
            currentOperand->contents.variable.name = tree->kind.decl.name;
            currentOperand->contents.variable.scope = tree->kind.decl.scope;
            op1 = currentOperand;
            //generates array position
            cGen(p1, codeInfo);
            //array index
            op2 = currentOperand;
            
            currentInstruction = VEC;
            //we need a temporary for this operation
            op3 = (Operand) malloc(sizeof(struct operand));
            op3->kind = String;
            op3->contents.variable.scope = NULL;
            op3->contents.variable.name = createTemporaryOperandName();

            currentOperand = op3;
            //if we are accessing and not declaring, add a new quadruple entry
            if(tree->kind.decl.access == Access) {
                //stores last instruction so we can access array address
                quadArray->instruction = VEC;
                quadArray->op1 = op1;
                quadArray->op2 = op2;
                quadArray->op3 = op3;
                quadArray->line = ++line;
                quadArray->next = NULL;
                lastQuadruple = quadArray;
                insertQuad(lastQuadruple);
            }
            break; 

        case Function: //type_specifier id OPAREN params CPAREN compound_stmt
            //checks if we have a return, if not, we had one
            checkEndOfFunction();
            op1 = (Operand) malloc(sizeof(struct operand));
            op1->kind = String;
            op1->contents.variable.name = tree->kind.decl.name;
            op1->contents.variable.scope = tree->kind.decl.scope;
            //new table entry
            quadFunction->instruction = FUNC;
            quadFunction->op1 = op1;
            quadFunction->op2 = NULL;
            quadFunction->op3 = NULL;
            quadFunction->line = ++line;
            quadFunction->next = NULL;
            insertQuad(quadFunction);

            //we create as many quadruple entries as there are parameters
            p1 = tree->child[0];
            while(p1 != NULL) {
                op2 = (Operand) malloc(sizeof(struct operand));
                op2->kind = String;
                op2->contents.variable.name = p1->child[0]->kind.decl.name;
                op2->contents.variable.scope = p1->child[0]->kind.decl.scope;
                insertQuad(createQuad(GET_PARAM, op2, NULL, NULL));
                //quadParam->instruction = GET_PARAM;
                //quadParam->op1 = op2;
                //quadParam->op2 = NULL;
                //quadParam->op3 = NULL;
                //quadParam->line = ++line;
                //quadParam->next = NULL;
                //insertQuad(quadParam);

                p1 = p1->sibling;
            }

            ///generates compound statement
            p2 = tree->child[1];
            cGen(p2, codeInfo);
            break;

        case Call: //var OPAREN args CPAREN
            
            
            p1 = tree->child[0]; //args
            //sets as first operand
            op1 = (Operand) malloc(sizeof(struct operand));
            op1->kind = String;
            op1->contents.variable.name = tree->kind.decl.name;
            op1->contents.variable.scope = tree->kind.decl.scope;
            //we need the quantity of parameters
            qtdParams = getParamQuantity(tree);
            pushParam(&qtdParams);
            //sets second operand
            op2 = (Operand) malloc(sizeof(struct operand));
            if(qtdParams > 0) {
                op2->kind = IntConst;
                op2->contents.val = qtdParams;
            } else {
                op2->kind = IntConst;
                op2->contents.val = 0;
            }
            //new quadruple entry
            currentInstruction = PARAM_LIST;
            op3 = (Operand) malloc(sizeof(struct operand));
            op3->kind = IntConst;
            op3->contents.val = getParamQuantity(tree);

            quadCall->instruction = PARAM_LIST;
            quadCall->op1 = op3;
            quadCall->op2 = NULL;
            quadCall->op3 = NULL;
            quadCall->line = ++line;
            quadCall->next = NULL;
            insertQuad(quadCall);
            //we add as many new quadruple entries as there are parameters
            while(p1 != NULL) {
                cGen(p1, codeInfo);
                currentInstruction = SET_PARAM;
                //new quadruple representation
                insertQuad(createQuad(currentInstruction, currentOperand, NULL, NULL));
                //quadCall2->instruction = SET_PARAM;
                //quadCall2->op1 = currentOperand;
                //quadCall2->op2 = NULL;
                //quadCall2->op3 = NULL;
                //quadCall2->line = ++line;
                //quadCall2->next = NULL;
                //insertQuad(quadCall2);                
                --qtdParams;
                if((strcmp(tree->kind.decl.name, "output") == 0) && p1->sibling == NULL){
                    display = p1->kind.decl.value;
                }
                
                p1 = p1->sibling;
            }
            popParam();
            currentInstruction = CALL;
                       
            
            //we need a temporary for this operation
            currentOperand = (Operand) malloc(sizeof(struct operand));
            currentOperand->kind = String;
            currentOperand->contents.variable.scope = NULL;
            currentOperand->contents.variable.name = createTemporaryOperandName();
            //new quadruple entry
            quadCall3->instruction = CALL;
            quadCall3->op1 = op1;
            quadCall3->op2 = op2;
            quadCall3->op3 = currentOperand;
            quadCall3->line = ++line;
            quadCall3->next = NULL;
            if(display != -1){
                quadCall3->display = display;
            }
            insertQuad(quadCall3);
            break;
    }
}




static void cGen(TreeNode * tree, CodeType codeInfo) {
    if (tree != NULL) {
        switch (tree->nodekind) {
            case Stmt:
                genStmt(tree, codeInfo);
                break;
            case Exp:
                genExp(tree, codeInfo);
                break;
            case Decl:
                genVar(tree, codeInfo);
                break;
            default:
                break;
        }
        //this is for function call
        //if there are more the 0 parameters, cgen is called back automatically
        if(paramHead == NULL) {
            cGen(tree->sibling, codeInfo);
        } else {
            if(paramHead->count == 0) {
                cGen(tree->sibling, codeInfo);
            }
        }
    }
}

void checkEndOfFunction(void) {
    if(head != NULL) {
        Quadruple temp = head;
        while(temp->next != NULL) {
            temp = temp->next;
        }
        //this is where we insert a return of there is none
        if(temp->instruction != RTN) {
            Quadruple quadFim = (Quadruple) malloc(sizeof(struct Quad));
            quadFim->instruction = RTN;
            quadFim->op1 = NULL;
            quadFim->op2 = NULL;
            quadFim->op3 = NULL;
            quadFim->line = ++line;
            quadFim->next = NULL;
            insertQuad(quadFim);
        }
    }
}


/**********************************************/
/* the primary function of the code generator */
/**********************************************/
/* Procedure codeGen generates code to a code
 * file by traversal of the syntax tree. The
 * second parameter (codefile) is the file name
 * of the code file, and is used to print the
 * file name as a comment in the code file
 */
void codeGen(TreeNode * syntaxTree, char * codefile, CodeType codeInfo) {
    char * s = (char *) malloc(strlen(codefile) + 7);

    Quadruple quads = (Quadruple) malloc(sizeof(struct Quad));


    strcpy(s,"File: ");
    strcat(s,codefile);
    fprintf(code, "# C- Compilation for intermediate code\n" );
    //fprintf(code, "#%s\n", s);
    cGen(syntaxTree, codeInfo);

    //fprintf(code, "# The end\n" );
    fprintf(code, "\n***************************************\n\n" );
    //fprintf(code, "\n***************************************" );
    //fprintf(code, "\n********** Intermediate Code **********" );
    //fprintf(code, "\n***************************************\n\n" );
    
    /*if(codeInfo == PROGRAMA){ //se eh programa
        quads->instruction = SYSCALL;
        quads->op1 = NULL;
        quads->op2 = NULL;
        quads->op3 = NULL;
        quads->line = ++line;
        quads->next = NULL;
        insertQuad(quads);
    }
    else{ //se eh kernel/bios
        quads->instruction = HALT;
        quads->op1 = NULL;
        quads->op2 = NULL;
        quads->op3 = NULL;
        quads->line = ++line;
        quads->next = NULL;
        insertQuad(quads);
    }*/
    

    printIntermediateCode();
}

void printIntermediateCode() {
    Quadruple q = head;
    char quad[100];

    while(q != NULL) {
        sprintf(quad, "%d: (", q->line);
        strcat(quad, copyInstruction(q->instruction));

        if(q->op1 == NULL) {
            strcat(quad, ", _");
        } else if(q->op1->kind == String) {
            strcat(quad, ", ");
            strcat(quad, q->op1->contents.variable.name);
        } else {
            sprintf(tempString, ", %d", q->op1->contents.val);
            strcat(quad,tempString);
        }

        if(q->op2 == NULL) {
            strcat(quad, ", _");
        } else if(q->op2->kind == String) {
            strcat(quad, ", ");
            strcat(quad, q->op2->contents.variable.name);
        } else {
            sprintf(tempString, ", %d", q->op2->contents.val);
            strcat(quad,tempString);
        }

        if(q->op3 == NULL) {
            strcat(quad, ", _)");
        } else if(q->op3->kind == String) {
            strcat(quad, ", ");
            strcat(quad, q->op3->contents.variable.name);
            strcat(quad, ")");
        } else {
            sprintf(tempString, ", %d", q->op3->contents.val);
            strcat(quad,tempString);
            strcat(quad, ")");
        }
        //emitCode(quad);
        fprintf(code, "%s\n", quad);
        q = q->next;
    }
}

void pushParam(int * count) {
    ParamStack ps = (ParamStack) malloc(sizeof(struct Param));
    ps->count = count;
    ps->next = NULL;
    if(paramHead == NULL) {
        paramHead = ps;
    } else {
        ps->next = paramHead;
        paramHead = ps;
    }
}

void popParam(void) {
    if(paramHead != NULL) {
        ParamStack ps = paramHead;
        paramHead = paramHead->next;
        free(ps);
        ps = NULL;
    }
}

Quadruple * insertQuad(Quadruple q) {
    Quadruple p = head;
    Quadruple *ptr = (Quadruple *) malloc(sizeof(struct Quad));
    *ptr = q;
    if(p == NULL) {
        head = *ptr;
        head->next = NULL;
    } else {
        while(p->next != NULL) {
            p = p->next;
        }
        p->next = *ptr;
        p->next->next = NULL;
    }
    return ptr;
}

Quadruple createQuad(InstructionKind instruction, Operand op1, Operand op2, Operand op3) {
    Quadruple q = (Quadruple) malloc(sizeof(struct Quad));
    q->instruction = instruction;
    q->op1 = op1;
    q->op2 = op2;
    q->op3 = op3;
    q->line = ++line;
    q->next = NULL;
    return q;
}

int getParamQuantity(TreeNode * node) {
    int qty = 0;
    TreeNode * aux = node->child[0];
    if(aux != NULL) {
        ++qty;
        while(aux->sibling != NULL) {
            aux = aux->sibling;
            ++qty;
        }
    }
    return qty;
}


Quadruple getCodigoIntermediario(void) {
    return head;
}