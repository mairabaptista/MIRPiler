/****************************************************/
/* Arquivo: main.c                                  */
/* Main program for C- compiler                     */
/****************************************************/

#include "globals.h"

/* set NO_PARSE to TRUE to get a scanner-only compiler */
#define NO_PARSE FALSE
/* set NO_ANALYZE to TRUE to get a parser-only compiler */
#define NO_ANALYZE FALSE

/* set NO_CODE to TRUE to get a compiler that does not
 * generate code
 */
#define NO_CODE FALSE

/* NO_TARGET_CODE igual a TRUE não gera código objeto,
 * caso contrário gera código objeto
 */
#define NO_TARGET_CODE FALSE

/* NO_TARGET_CODE igual a TRUE não gera código binário,
 * caso contrário gera código binário
 */
#define NO_BINARY_CODE TRUE

#include "util.h"
//#include "cli.h"
#if NO_PARSE
#include "scan.h"
#else
#include "parse.h"
#if !NO_ANALYZE
#include "analyze.h"
#if !NO_CODE
#include "cgen.h"
#if !NO_TARGET_CODE
#include "target.h"
#if !NO_BINARY_CODE
#include "binary.h"
#endif
#endif
#endif
#endif
#endif

/* allocate global variables */
int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;
FILE * asm_file;
FILE * binary_file;

/* allocate and set tracing flags */
int EchoSource = FALSE;
int TraceScan = TRUE;
int TraceParse = TRUE;
int TraceAnalyze = TRUE;
int TraceCode = TRUE;
int TraceTarget = TRUE;
int TraceBinary = TRUE;

int Error = FALSE;
int codigoIntermediarioGerarado = FALSE;
int codigoObjetoGerado = FALSE;

// ./compiler arquivo modo

CodeType codeInfo;

int main(int argc, char * argv[]) {
    TreeNode * syntaxTree;
    char pgm[120];
    /*if (argc == 1) {
        mostrarErroArgumentos(argv[0]);
    }*/
    if(argc != 3){
        fprintf(stderr, "Usage: %s <filename> \n", argv[0]);
        exit(1);
    }
    strcpy(pgm, argv[1]);
    if (strchr (pgm, '.') == NULL)
     strcat(pgm,".tny");
    source = fopen(pgm,"r");
    if (source==NULL){ 
        fprintf(stderr,"File %s not found\n",pgm);
        exit(1);
    }
    codeInfo = atoi(argv[2]);



    //CodeInfo codeInfo = interpretar(argc, argv);    
    listing = stdout; /* send listing to screen */
    fprintf(listing, "\nC- COMPILATION: %s\n", pgm);
#if NO_PARSE
    while (getToken() != ENDFILE);
#else
    syntaxTree = parse();
    if (TraceParse) {
        fprintf(listing, "\nSyntax tree:\n\n");
        printTree(syntaxTree);
    }
#if !NO_ANALYZE
    if (! Error) {
        if (TraceAnalyze) fprintf(listing, "\nBuilding symbol table...\n");
        buildSymtab(syntaxTree);
        if (TraceAnalyze) fprintf(listing, "\nChecking types...\n");
        typeCheck(syntaxTree);
        if (TraceAnalyze) fprintf(listing, "\nDone checking types\n");
    }
#if !NO_CODE
    if (! Error) {
        char * codefile;
        int fnlen = strcspn(/*codeInfo.*/pgm, ".");
        codefile = (char *) calloc(fnlen + 4, sizeof(char));
        strncpy(codefile, /*codeInfo.*/pgm, fnlen);
        strcat(codefile, ".txt");
        code = fopen(codefile, "w");
        if (code == NULL) {
            printf("Unable to open %s\n", codefile);
            exit(1);
        }
        if (TraceCode) fprintf(listing, "\nGenerating Intermediate Code\n");
        codeGen(syntaxTree, codefile, codeInfo);
        free(syntaxTree);
        fclose(code);
        if (TraceCode) fprintf(listing, "\nIntermediate code generation completed\n");
        // Código intermediário gerado com sucesso
        codigoIntermediarioGerarado = TRUE;
    }
#if !NO_TARGET_CODE
    if(codigoIntermediarioGerarado) {
        char * codefile;
        char * asmFile;
        int fnlen = strcspn(pgm, ".");
        codefile = (char *) calloc(fnlen + 4, sizeof(char));
        strncpy(codefile, pgm, fnlen);
        strcat(codefile, ".txt");
        code = fopen(codefile, "a+");
        Quadruple codigoIntermediario = getCodigoIntermediario();
        if (TraceTarget) fprintf(listing, "\nGenerating Target Code...\n");

        //separate file for asm code
        asmFile = (char *) calloc(fnlen + 4, sizeof(char));
        strncpy(asmFile, pgm, fnlen);
        strcat(asmFile, ".asm");
        asm_file = fopen(asmFile, "w");

        geraCodigoObjeto(codigoIntermediario, codeInfo);
        fclose(code);
        fclose(asm_file);
        if (TraceTarget) fprintf(listing, "\nDone Generating Target Code!\n");
        // Código objeto gerado com sucesso
        codigoObjetoGerado = TRUE;
    }
#if !NO_BINARY_
    
#endif
#endif
#endif
#endif
#endif
    fclose(source);
    return 0;
}
