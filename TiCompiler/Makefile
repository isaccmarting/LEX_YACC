all: main.o tiger.o errormsg.o util.o
	gcc -o tiger main.o tiger.o errormsg.o util.o

main.o: main.c errormsg.h util.h tokens.h
	gcc -o main.o -c main.c

tiger.o: tiger.c
	gcc -o tiger.o -c tiger.c

tiger.c: tiger.lex
	flex -o tiger.c tiger.lex

util.o: util.c util.h
	gcc -o util.o -c util.c

errormsg.o: errormsg.c errormsg.h util.h
	gcc -o errormsg.o -c errormsg.c

clean:
	rm tiger.c
	rm *.o
	rm *.exe