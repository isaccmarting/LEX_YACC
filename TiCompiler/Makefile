all: main.o tiger.o tiger.tab.o errormsg.o util.o
	gcc -o tiger main.o tiger.o tiger.tab.o errormsg.o util.o

main.o: main.c errormsg.h util.h tiger.tab.h
	gcc -o main.o -c main.c

tiger.o: tiger.c
	gcc -o tiger.o -c tiger.c

tiger.c: tiger.lex tiger.tab.h
	flex -o tiger.c tiger.lex

tiger.tab.o: tiger.tab.c tiger.tab.h
	gcc -o tiger.tab.o -c tiger.tab.c

tiger.tab.c tiger.tab.h: tiger.y
	bison -dv tiger.y

util.o: util.c util.h
	gcc -o util.o -c util.c

errormsg.o: errormsg.c errormsg.h util.h
	gcc -o errormsg.o -c errormsg.c

clean:
	rm tiger.tab.c tiger.tab.h tiger.output
	rm tiger.c
	rm *.o
	rm *.exe