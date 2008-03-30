(*
	OCRe - The ultimate OCR - HUGE Software
	OCRe is a project developed by 2nd year EPITA students
	- website: http://huge.ocre.free.fr/
	- svn repository: http://code.google.com/p/ocre

	About this folder:	OCRed
		OCRed is the preprocessing part of OCRe.
	About this file:	OCRed/main.ml
		This is the main.ml file.
*)

let init () =
Sdl.init [`VIDEO;`EVENTTHREAD;`TIMER];
          Sdlkey.enable_unicode true;
          Sdlkey.enable_key_repeat ()

let main () =
  Arg.parse
    (Arg.align Argument.speclist)
    (fun _ -> ())
    Argument.usage;
  if !Argument.display then
    begin
      try
        init ();
         let (w,h) = Surface.taille !Surface.image in
          Surface.set_screen w h;
          Event.run ()
      with
        | Event.Quit_input ->  Sdl.quit ()
        | Event.Quit_onmouse -> Sdl.quit ()
    end;
  if (!Argument.dev) then
    begin
      init ();
      Event.dev ();
      Sdl.quit ()
    end
  else
    begin
      if (* (!Argument.seuil)&&  *)(!Argument.rotate)then
        begin
          init ();
          (*           Seuil.main (); *)
          Event.rotate ();
          Sdl.quit ()
        end;
      if (!Argument.seuil) then
        begin
          init ();
          Seuil.main ();
          Sdl.quit ()
        end
      else
        begin
          init ();
          Event.action ();
          Sdl.quit ()
        end
    end


let _ = main ()