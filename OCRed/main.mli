(*
	OCRe - The ultimate OCR - HUGE Software
	OCRe is a project developed by 2nd year EPITA students
	- website: http://huge.ocre.free.fr/
	- svn repository: http://code.google.com/p/ocre

	About this folder:	OCRed
		OCRed is the preprocessing part of OCRe.
	About this file:	OCRed/main.mli
		This is the main.mli file.
*)
(** Create the sdl video and keyboard for the --display option*)
val init : unit -> unit
(** *)
val main : unit -> unit
