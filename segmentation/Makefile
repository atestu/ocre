#
# OCRe - The ultimate OCR - HUGE Software
# OCRe is a project developed by 2nd year EPITA students
# - website: http://huge.ocre.free.fr/
# - svn repository: http://code.google.com/p/ocre
#
# About this folder: /extraction
#   OCRec is the character extraction part of OCRe.
# About this file: /extraction/Makefile
#   This is the makefile of the extraction part.

# Compiler
CC=gcc

# Flags
CFLAGS= -W -Wall -Werror -pedantic -ansi -pipe -g

# Target
TARGET= seg

$(TARGET): main.c args.c binarization.c export.c infos.c init.c graphics.c pixel.c launch.c process.c projections.c print.c free.c segmentation.c tools.c wrappers.c
	gcc $(CFLAGS) `sdl-config --cflags --libs` main.c args.c binarization.c export.c infos.c init.c graphics.c pixel.c launch.c process.c projections.c print.c free.c segmentation.c tools.c wrappers.c -o $(TARGET)

clean:
	rm -f *~ *.o core
	rm -f extract

bak:
	cp *.[ch] Makefile Backup/

