/**
 * Define a grammar called Hello

 */
grammar MiniJava;
@header {    
	 package cc1.zs222bv.miniJava;
}
 /*
  * Syntax Analysis Part , WITH ????? PART MEANS SUSPECTED PROBLEMS
 */
// §1. MiniJava main structure
miniJavaProgram : mainClass (classDeclaration)*;
mainClass : 'class' ID LC mainMthod RC ;
classDeclaration : 'class' LC fieldDeclaration* method RC ;
states : state+ ; //statements block
state : LC states RC
	  | variableDeclaration
	  | ifStmt
      | printStmt
      | assignStmt
      | whileStmt
      | arrStmt
	  ;

// §2. details inside the mainClass
mainMthod: 'public' 'static' 'void' 'main' LRB STR (LB RB | VARARGS ) ID RRB 
			LC state RC ;

// §3. details inside the normal class
fieldDeclaration: types ID SC ;
method : 'public' types ID LRB parameters? RRB LC variableDeclaration? states retState RC ;
types : INT
	  | BOO
	  | CHA
      | INTARR
	  | STR 
	  | ID
	  ;
parameters : types ID ( COMMA types ID )* ;

// §4. the details of method
variableDeclaration : intVDec
					|strVDec
					|booVDec
					|chaVDec 
					|refVDec
					|intArrVDec
					;
refVDec: ID ID (ASSIGN reference)? SC ;

chaVDec: CHA ID (ASSIGN  character)? SC ;

booVDec: BOO ID (ASSIGN bool)? SC ;

strVDec: STR ID (ASSIGN string)? SC ;

intVDec: INT ID (ASSIGN integer)? SC;

intArrVDec : INTARR ID (ASSIGN ('new' INT LB PO_INTEGER RB 
								| LC (integer | CHARACTER) (COMMA (integer | CHARACTER))* RC))? 
								;//int array variable declaration

string : STRING 
	   | STRING PLUS STRING
	   | STRING PLUS CHARACTER 
	   | THIS? ID (DOT ID LRB argList? RRB)* 
	   ;
integer : INTEGER 
	    | ID DOT 'length' LRB RRB
		| THIS? ID (DOT ID LRB argList? RRB)* 
		| ID LB PO_INTEGER RB //the int array like b[3]
		;
character : CHARACTER 
		  | (ID | string) DOT 'charAt' LRB PO_INTEGER RRB 
		  | THIS? ID (DOT ID LRB argList? RRB)* 
		  ;
		  
bool : BOOLEAN 
	   | ID
	   | THIS? ID (DOT ID LRB argList? RRB)* 
	   ;
reference : ID 
		  | 'new' ID LRB RRB 
		  | THIS? ID (DOT ID LRB argList? RRB)* 
		  ;
argList: fullTypes (COMMA fullTypes)* ;  //arguments for method call e.g. m(a,d)
retState : 'return' fullTypes SC ;
fullTypes : reference 
          | character
          | bool
          | string
          | integer
          ;

// §5. the details of state,i.e statement

/*
 * String concatenation (+), length check (.length()), and character access (e.g. .charAt(7)). 
   The only applicable operators on characters are ==, <, and concatenation with strings. 
 */		

boolExpn : NON  LRB boolExp RRB;

boolExp :  subBoolExpre ((AND | OR) subBoolExpre)* | boolExpn ;

subBoolExpre : charBooExpre 
			 | expreForBool  
			 | bool
			 ;

boolBoolExpre : bool EQUALS bool ;
charBooExpre : character (EQUALS | LESSTHAN) character ;
expreForBool : expre (EQUALS | LESSTHAN) expre ;

expre : rBExpre
		| expre (MULT | DIV) expre
		| expre (PLUS | MINUS) expre
        | (integer | ID)
        ;
rBExpre : LRB expre RRB ;
  
// § 5.1 statement details , while statement
whileStmt: WHILE LRB boolExp RRB LC (states | BREAK | CONTINUE) RC ;
// § 5.2 statement details , if statement
ifStmt : IF LRB boolExp LRB LC? states RC? elsePart ;
elsePart : (ELSE LC? states RC?)* ;
// § 5.3 statement details , assign statement
 assignStmt : ID ASSIGN expre SC ;
// § 5.4 statement details , array statement
arrStmt : ID LB integer RB ASSIGN integer SC ;
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
WS : [\r\t\n]+ -> skip ; // skip spaces, tabs, newlines

LETTER : [a-zA-Z_$];
DIGIT : [0-9];
ID: LETTER(LETTER|DIGIT)*;
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
