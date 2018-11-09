/**
 * Define a grammar called MiniJava
 */
grammar MiniJava;

miniJavaProgram : mainClass (ClassDeclaration)*;	

mainClass: 'class' ID LC mainMethod RC;

mainMethod: 'public' 'static' 'void' 'main' LRB STR LB RB ID RRB LC Statement RC;

Statement : ;

ClassDeclaration : 'class' ID LC Method RC;

Method : 'public' INT|STR|BOO|CHA|INTARR ID LRB INT|STR|BOO|CHA|INTARR ID RRB LC Statement RC;

AssignStatement : INTAssign|STRAssign|BOOAssign|CHAAssign;

INTAssign : INT ID (ASSIGN DIGIT+)? SC;

STRAssign : STR ID (ASSIGN '"' (DIGIT|LETTER|PLUS|MINUS|MULT|DIV|LESSTHAN|EQUALS|AND|OR|NON)* '"')? SC;

BOOAssign : BOO ID (ASSIGN 'true'|'false')? SC;

//CHAAssign : CHA ID (ASSIGN LETTER | )? SC;







 NON : '!';
 OR : '||';
 LESSTHAN : '<';
 AND :'&&';
 EQUALS : '==';
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
 SC : ';' ;
 
 
 LETTER : [a-zA-Z];
 DIGIT : [0-9];
 ID: LETTER(LETTER|DIGIT)*;
 WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
 
 INT: 'int' ;
 BOO: 'boolean';
 CHA: 'char';
 INTARR: 'int[]';
 STR: 'String' ;
 