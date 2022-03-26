# makes isaproject.o
# % make
# % make isa
# % make clean
CC = chasm
CFLAGS = > isaproject.o

default: isa

isa: isaproject.s
	@echo 'building isaproject.o.'
	$(CC) isaproject.s $(CFLAGS)

clean:
	rm -f isaproject.o
