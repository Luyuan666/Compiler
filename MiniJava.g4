/**
 * Define a grammar called Hello

 */
grammar MiniJava;
@header {    
	 package cc1.zs222bv.miniJava;
}
 /*
  * Syntax Analysis Part 

 */
// §1. MiniJava main structure
miniJavaProgram : mainClass classDeclaration*;
mainClass : 'class' id LC mainMthod RC ;
classDeclaration : 'class' id LC fieldDeclaration* method RC ;
states : state+ ; //statements block
state : LC states RC
	  | variableDeclaration
	  | ifStmt
      | printStmt
      | assignStmt
      | whileStmt
      | arrStmt
      | BREAK SC
      | CONTINUE SC
	  ;

// §2. details inside the mainClass
mainMthod: 'public' 'static' 'void' 'main' LRB STR (LB RB | VARARGS ) id RRB //？
			LC state RC ;

// §3. details inside the normal class
fieldDeclaration: types id SC ;
method : 'public'? types id LRB parameters? RRB LC variableDeclaration? states retState RC ;//？
types : INT
	  | BOO
	  | CHA
      | INTARR
	  | STR 
	  | id
	  ;

parameters : types id ( COMMA types id )* ;

// §4. the details of method
variableDeclaration : intVDec
					|strVDec
					|booVDec
					|chaVDec 
					|refVDec
					|intArrVDec
					;
refVDec: id  id (ASSIGN reference)? SC ;

chaVDec: CHA id (ASSIGN  character)? SC ;

booVDec: BOO id (ASSIGN bool)? SC ;

strVDec: STR id (ASSIGN string)? SC ;

intVDec: INT id (ASSIGN integer)? SC;

intArrVDec : INTARR id (ASSIGN ('new' INT LB PO_INTEGER RB 
								| LC (integer | CHARACTER) (COMMA (integer | CHARACTER))* RC))? 
								;//int array variable declaration
id : LETTER(LETTER|DIGIT)* ;
string : STRING 
	   | STRING PLUS STRING
	   | STRING PLUS CHARACTER 
	   ;
integer : (INTEGER | DIGIT)
	    | id DOT 'length' LRB RRB
		| id LB PO_INTEGER RB //the int array like b[3]
		;

character : CHARACTER
		  | (id | string) DOT 'charAt' LRB PO_INTEGER RRB
		  ;
		  
bool : BOOLEAN;
reference : 'new' id (DOT? id LRB argList? RRB)* ;
argList: fullTypes (COMMA fullTypes)*;  //arguments for method call e.g. m(a,d)
retState : 'return' fullTypes SC ;
fullTypes : expre
		  | boolExp
		  | thisChainStmt
		  |	reference 
          | character
          | bool
          | string
          | integer
          ;
simple : id MINUS integer ;
thisChainStmt : id
			  | (THIS DOT)? id LRB argList? simple RRB (DOT id LRB argList? RRB)* 
			  ;
// §5. the details of state,i.e statement

/*
 * String concatenation (+), length check (.length()), and character access (e.g. .charAt(7)). 
   The only applicable operators on characters are ==, <, and concatenation with strings. 
 */		

boolExpn : NON  LRB boolExp RRB;

boolExp :  expre ((AND | OR) expre)* | boolExpn ;

expre : rBExpre
		| expre (MULT | DIV) expre 
		| expre (PLUS | MINUS) expre
		| expre (EQUALS | LESSTHAN) expre
		| character (EQUALS | LESSTHAN) character
		| bool EQUALS bool
        | (integer | id | thisChainStmt)
        ;
rBExpre : LRB expre RRB ;
  
// § 5.1 statement details , while statement
whileStmt: WHILE LRB boolExp RRB LC states RC ;
// § 5.2 statement details , if statement
ifStmt : IF LRB boolExp RRB LC? states RC? elsePart ;
elsePart : (ELSE LC? states RC?)* ;
// § 5.3 statement details , assign statement
 assignStmt : id ASSIGN expre SC ;
// § 5.4 statement details , array statement
arrStmt : id LB integer RB ASSIGN integer SC ;
// § 5.5 statement details , print statement
printStmt: 'System' DOT 'out' DOT 'println' LRB fullTypes RRB SC;



		
/*
 * Lexical parse part

*/
//operators
ASSIGN : '=' ;
PLUS : '+' ;
MINUS : '-' ;
MULT : '*' ;
DIV : '/' ;
LESSTHAN: '<' ;
EQUALS : '==' ;
AND : '&&' ;
OR : '||' ;
NON : '!' ;

//symbols
LRB : '(' ;           // Left Round Bracket
RRB : ')' ;
LB: '[';
RB: ']';
LC :'{' ;
RC :'}' ;
VARARGS : '...' ;
SC : ';' ;
COMMA : ',' ;
DOT : '.' ;
WS : [ \r\t\r\n]+ -> skip ; // skip spaces, tabs, newlines

LETTER : [a-zA-Z_$];
DIGIT : [0-9];
CHARACTER : '\'' ~['\\\r\n] '\'' ;
STRING :  '"' (~["\\\r\n])* '"';
INTEGER : '0'
		  | '-'? [1-9] ([1-9]|'0')*
		  ;
PO_INTEGER : '0'
		     | [1-9] ([1-9]|'0')*
		     ;

BOOLEAN : 'true'
		  | 'false'
		  ;

//types
INT : 'int' ;
BOO : 'boolean';
CHA : 'char';
INTARR : 'int' '[' ']';
STR : 'String' ;

//key words
THIS :'this' ;
IF : 'if' ;
ELSE : 'else' ;
WHILE : 'while' ;
BREAK : 'break';
CONTINUE :'continue';
