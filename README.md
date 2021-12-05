# Goyacc Thermostat

Classical yacc thermostat example (https://tldp.org/HOWTO/Lex-YACC-HOWTO-4.html#ss4.1) implemented using goyacc and a simple text/scanner

## Example

```
$ cat thermo.stat

heat on
heat off
target temperature 22

$ ./tsparse thermo.stat

heat on
	Heat turned on
heat off
	Heat turned off
target temperature 22
	New temperature set to 22!

```
