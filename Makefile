
OUTD := dist# Output folder
OUTF := out# Output file

OUTF := $(OUTD)/$(OUTF)

CC := gcc# Compiler for c
CPP := g++# Compiler for c++

CFLAGS := -Wall# Flags for gcc
CPPFLAGS := -Wall# Flags for g++

ODIR := obj# Object directory
SDIR := src# Source directory

#SRC:=$(wildcard $(SDIR)/*.c)
#SRC := $(shell find ./src/*.c)
SRC := $(shell find ./src -type f \( -iname \*.c -o -iname \*.cpp \) )
SRC_C := $(shell find ./src -type f \( -iname \*.c \) )
SRC_CPP := $(shell find ./src -type f \( -iname \*.cpp \) )
SRC_H := $(shell find ./src -type f \( -iname \*.h \) )

#OBJS := $(patsubst $(SDIR)/%.c, $(SDIR))
#OBJS := $(patsubst $(SDIR)/%.cpp, $(OBJS))
OBJS_C := $(SRC_C:.c=.o)
OBJS_C := $(subst $(SDIR),$(ODIR),$(OBJS_C))

OBJS_CPP := $(SRC_CPP:.cpp=.o)
OBJS_CPP := $(subst $(SDIR),$(ODIR),$(OBJS_CPP))

.PHONY: clean run init all
all: $(OBJS_C) $(OBJS_CPP) $(OUTF)

$(OBJS_C): $(SRC_C) $(SRC_H) # Compile c files
	$(CC) -c $(CFLAGS) $(SRC_C) -o $@

$(OBJS_CPP): $(SRC_CPP) $(SRC_H) # Compile c++ files
	$(CPP) -c $(CPPFLAGS) $(SRC_CPP) -o $@


$(OUTF): $(OBJS_C) $(OBJS_CPP)# compile all object files to the program
	$(CC) -o $@ $(OBJS_C) $(OBJS_CPP)
#main.exe: $(OBJ_FILES)
#	g++ $(LDFLAGS) -o $@ $^

test:
	@echo $(SRC_C)
	@echo $(OBJS_C)

	@echo $(SRC_CPP)
	@echo $(OBJS_CPP)

	@echo $(OUTF)

# @ suppresses the normal 'echo' of the command

# - means ignore the exit status of the command

init:
	-mkdir $(SDIR)
	-mkdir $(ODIR)
	-mkdir $(OUTD)

clean:
	-rm $(ODIR)/*.o
	-rm $(OUTF)
rebuild:
	make clean
	make
run:
	@./$(OUTF)