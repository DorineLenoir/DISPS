test_IIR_filter: test_IIR_filter.o IIR_filter.o
	gcc -o test_IIR_filter test_IIR_filter.o IIR_filter.o

test_IIR_filter.o: test_IIR_filter.c source_signal.h
	gcc -o test_IIR_filter.o -c test_IIR_filter.c -W -Wall -ansi -pedantic

IIR_filter.o: ../src/IIR_filter.c
	gcc -o IIR_filter.o -c ../src/IIR_filter.c -W -Wall -ansi -pedantic


