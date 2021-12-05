buildrun(){
	EXECFILE=tsparse
	rm -f $EXECFILE
	goyacc app.y
	go build
	[ -f $EXECFILE ] && ./$EXECFILE thermo.stat
}
doparse(){
	(cd ../09-scanner; go build;)
	../09-scanner/scan ./input.hw;
}
case "$1" in
e)	vi -p app.y input.hw
	buildrun
	;;
p)	doparse
	;;
"")	buildrun
	;;
esac
