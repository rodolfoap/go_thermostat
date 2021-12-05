%{
package main
import("os"; "text/scanner"; "log"; "fmt")
%}
%union {
	value string
}
%token TOKHEAT;
%token TOKTARGET;
%token TOKTEMPERATURE;
%token STATE;
%token NUMBER;
%%
commands: /* empty */
        | commands command
        ;

command: heat_switch
        | target_set
        ;

heat_switch:
        TOKHEAT STATE
        { fmt.Printf("\n\tHeat turned %v\n", $2.value); }
        ;

target_set:
        TOKTARGET TOKTEMPERATURE NUMBER
        { fmt.Printf("\n\tNew temperature set to %v!\n", $3.value); }
        ;
%%
type MainLex struct{ scanner.Scanner }
func(l *MainLex)Lex(lval *yySymType)int{
	token, lit := l.Scan(), l.TokenText()
	//log.Printf("\tToken: %-10v\tliteral: %-15s\n", scanner.TokenString(token), lit)

	switch int(token){
	case scanner.Ident:
		fmt.Printf("%v ", lit)
		switch lit{
		case "heat":
			return TOKHEAT;
		case "on", "off":
			lval.value=lit; return STATE
		case "target":
			return TOKTARGET;
		case "temperature":
			return TOKTEMPERATURE;
		default:
			l.Error("Unrecognized token.")
		}
	case scanner.Int:
		lval.value=lit;
		return NUMBER
	}
	return 0
}

func (x *MainLex) Error(s string) {
	fmt.Printf("\n")
	log.Printf("Parse error: %s", s)
}

func main() {
	if len(os.Args)==1{fmt.Println("Usage:", os.Args[0], "[FILE]"); return}

	file, err:=os.Open(os.Args[1])
	if err!=nil{log.Printf("File not found")}
	defer file.Close()

	s:=new(MainLex)
	s.Init(file)
	yyParse(s)
}
