#Makefile for the sorting test

SHELL = /bin/sh

#clear suffixes and then set
.SUFFIXES:
.SUFFIXES: .c .o .h

CC = /opt/rh/devtoolset-7/root/usr/bin/gcc
  
# compiler flags:
#  	-Wall turns on most, but not all, compiler warnings
#	-O3 turns on compiler optimizations
#	-lrt links the rt library
#	-std sets the language standard
CFLAGS = -Wall -O3 -lrt -std=gnu11

TARGET = sorttest

default: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) $(TARGET).c -o $(TARGET)

clean:
	$(RM) $(TARGET) *.o *~ *.exe