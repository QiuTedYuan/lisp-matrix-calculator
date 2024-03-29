SRCS    = $(shell /bin/ls *.cc)
CFLAGS   = -DOP_ASSIGN

.SUFFIXES: $(SUFFIXES) .cpp

%.o: %.cpp
#	g++ -c $(CFLAGS) $<
	g++ -c $(CFLAGS) -fno-elide-constructors $<

OBJS = main.o parse.o eval.o Cell.o Except.o


main: $(OBJS)
	g++ -g $(CFLAGS) -o $@ $(OBJS) -lm

main.o: Cell.hpp cons.hpp parse.hpp eval.hpp main.cpp
	g++ -c -g main.cpp
	
parse.o: Cell.hpp cons.hpp parse.hpp parse.cpp
	g++ -c -g parse.cpp

eval.o: Cell.hpp cons.hpp eval.hpp eval.cpp
	g++ -c -g eval.cpp

Cell.o: Cell.hpp Except.hpp hashtablemap.hpp bstmap.hpp Cell.cpp
	g++ -c -g Cell.cpp

Except.o: Cell.hpp Except.hpp Except.cpp
	  g++ -c -g Except.cpp

doc:
	doxygen doxygen.config

test:
	rm -f testoutput.txt
	./main testinput.txt > testoutput.txt
	diff -w testreference.txt testoutput.txt

clean:
	rm -f core *~ $(OBJS) main main.exe testoutput.txt
