/**
 * Define a grammar called Hello

 */
grammar MiniJava;

 /*
  * Syntax Analysis Part 
 */
//1. MiniJava main structure
miniJavaProgram : mainClass (classDeclaration)*;

mainClass: 'class' ID LC mainMthod RC ;
classDeclaration: LC method RC ;

mainMthod: 'public' 'static' 'void' 'main' LRB STRINGTYPE (LB RB | VARARGS ) ID RRB 
			LC states ;
method : ;
states : state+ ; //statements block


/* state : expr SC
       | assign ; //single statement

rBExpr : LRB expr RRB ;   // Round bracket expression
expr :  rBExpr
        | expr (MULT | DIV) expr
        | expr (PLUS | MINUS) expr
        | (INT | ID)
     ;//left-recursive problem need to be solved
assign : ID ASSIGN expr SC ;*/


// § 2.1 statement details , while statement

// § 2.2 statement details , if statement

// § 2.3 statement details , assign statement

// § 2.4 statement details , array statement

// § 2.5 statement details , print statement

INT : [0-9]+; // match integer
ASSIGN : '=' ;
PLUS : '+' ;
MINUS : '-' ;
MULT : '*' ;
DIV : '/' ;
LRB : '(' ;           // Left Round Bracket
RRB : ')' ;
LB: '[';
RB: ']';
LC :'{' ;
RC :'}' ;
VARARGS : '...' ;
//ALP : [a-z|A-Z]+ ; 
//ID : [a-z]+ ;             // match lower-case identifiers
LETTER : [a-zA-Z];
DIGIT : [0-9];
ID: LETTER(LETTER|DIGIT)*;
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
SC : ';' ;
STRINGTYPE: 'String' ;
INTTYPE: 'int' ;

