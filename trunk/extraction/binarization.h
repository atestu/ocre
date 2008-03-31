/**
 * OCRe - The ultimate OCR - HUGE Software
 * OCRe is a project developed by 2nd year EPITA students
 * - website: http://huge.ocre.free.fr/
 * - svn repository: http://code.google.com/p/ocre
 *
 * About this folder: OCRec
 *   OCRec is the character extraction part of OCRe.
 * About this file: OCRec/binarization.h
 *   This is the header of "binarization.c".
 */

#ifndef BINARIZATION_H
#define BINARIZATION_H

#endif /* BINARIZATION_H */

#include "SDL/SDL.h"

/**
 * This function converts a bitmap image
 * into a binary image.
 * @param image A bitmap image loaded in an allocated SDL surface.
 * @param filename Name of the bitmap file.
 * @return Binary image.
 */
t_binary_image *bitmap_to_binaryimage(SDL_Surface *image,
				      char *filename);