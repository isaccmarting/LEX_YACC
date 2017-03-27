CalInt:
	bison -d CalIntDouble.y
	flex -o CalIntDouble.lex.c CalIntDouble.l
	gcc -o CalIntDouble CalIntDouble.lex.c CalIntDouble.tab.c -lfl

clean:
	rm CalIntDouble.tab.h CalIntDouble.tab.c
	rm CalIntDouble.lex.c
	rm *.exe
