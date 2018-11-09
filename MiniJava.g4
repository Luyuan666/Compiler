/**
 * Define a grammar called Hello

 */
grammar MiniJava;
/*
 * MiniJavaProgram --> MainClass ( ClassDeclaration )* 

MainClass --> "class" Identifier "{" MainMethod  "}"
MainMethod --> "public" "static" "void" "main" "(" "String" ("[" "]" | "...") Identifier ")" "{" Statement "}"
 */
 /*
  * Syntax Analysis Part 
  */
//1. MiniJava main structure
miniJavaProgram : mainClass (classDeclaration)*;

mainClass: 'class' ID LC mainMthod RC;
classDeclaration: LC method RC;

mainMthod: 'public' 'static' 'void' 'main' LRB STRINGTYPE ('');
method: ;






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
//ALP : [a-z|A-Z]+ ; 
//ID : [a-z]+ ;             // match lower-case identifiers
LETTER : [a-zA-Z];
DIGIT : [0-9];
ID: LETTER(LETTER|DIGIT)*;
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
SC : ';' ;
STRINGTYPE: 'String' ;
INTTYPE: 'int' ;
