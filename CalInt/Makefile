CalInt:
	bison -d CalInt.y
	flex -o CalInt.lex.c CalInt.l
	gcc -o CalInt CalInt.lex.c CalInt.tab.c -lfl

clean:
	rm CalInt.tab.h CalInt.tab.c
	rm CalInt.lex.c
	rm *.exe
