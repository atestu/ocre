(*
	OCRe - The ultimate OCR - HUGE Software
	OCRe is a project developed by 2nd year EPITA students
	- website: http://huge.ocre.free.fr/
	- svn repository: http://code.google.com/p/ocre

	About this folder:	OCRed
		OCRed is the preprocessing part of OCRe.
	About this file:	OCRed/rotation.ml
		This is the rotation.ml file.
*)
let pi = 3.141592653
let rad = 180. /. pi
let deg = pi /. 180.
let degree_to_rad degree = float_of_int (degree) *. deg

let angle = ref 0.
let create_angle a= angle := (degree_to_rad a)

let foi x = float_of_int x
let iof x = int_of_float x
let soi x = string_of_int x
let sof x = string_of_float x

let mean_of_float x = match (modf x) with
  | (x,y) when (x >= 0.5)-> int_of_float(floor(y +. 1.))
  | (_,y) -> int_of_float(floor(y))

let direct_float x y theta=
  let x' =    x*.cos(theta) -. y*.sin(theta) in
  let y' =    x*.sin(theta) +. y*.cos(theta) in
    (mean_of_float x', mean_of_float y')

let direct_int i j theta=
  let x = float_of_int i in
  let y = float_of_int j in
  let x' =    x*.cos(theta) -. y*.sin(theta) in
  let y' =    x*.sin(theta) +. y*.cos(theta) in
    (mean_of_float x', mean_of_float y')

let inverse_float x y theta=
  let x' =    x*.cos(~-.theta) -. y*.sin(~-.theta) in
  let y' =    x*.sin(~-.theta) +. y*.cos(~-.theta) in
    (mean_of_float x',mean_of_float y')

let inverse_int i j theta=
  let x = float_of_int i in
  let y = float_of_int j in
  let x' =    x*.cos(~-.theta) -. y*.sin(~-.theta) in
  let y' =    x*.sin(~-.theta) +. y*.cos(~-.theta) in
    (mean_of_float x',mean_of_float y')

let hypotenuse surface =
  let (width,height,pitch) = Sdlvideo.surface_dims surface in
  let  hyp = sqrt(float_of_int(height*height + width*width)) in
   mean_of_float hyp

let center surface =
  let (width,height,pitch) = Surface.dim surface in
    match (width,height) with
      |(x,y) -> (x / 2,y / 2)


let is_in_rect x y width height =
  if (x > 0) && (x < width) && (y > 0) && (y <height) then
    true
  else
    false

let simple_surf surf angle=
  let (height,width,pitch) = Surface.dim surf in
  let (cy,cx) = center surf in
  let cote_hypot = hypotenuse surf  in
  let demi_hypot = cote_hypot / 2 in
  let my_output = Transforme.bigarray2 cote_hypot cote_hypot in
(** my output come from bigarray2 function in Transforme module*)
  let my_input = Transforme.surf_to_matrix surf in
    for i=0 to (width - 1) do
      for j=0 to (height - 1) do
        let (x,y) = direct_int (i - cx) (j - cy) angle in
            Bigarray.Array2.set
                my_output
                ( y + demi_hypot )
                ( x + demi_hypot )
                (Bigarray.Array2.get
                   my_input
                   (j)
                   (i));
      done;
    done;
  Transforme.matrix_to_surf my_output

let hard_of_surf surf angle =
  let (height,width,pitch) = Surface.dim surf in
  let hypot = hypotenuse surf  in
  let center = hypot / 2 in
  let cx = (center - width/2) in
  let cy = (center - height/2) in
    (*middle of the big matrix*)
  let my_output = Transforme.bigarray2 hypot hypot in
  let my_input = Transforme.surf_to_matrix surf in
    for i=0 to (hypot - 1) do
      for j=0 to (hypot - 1) do
        let (x,y) = inverse_int (i - center) (j - center) angle in
        let (x,y) = (x + center - cx,y + center - cy) in
          if (is_in_rect x y width height) then
            begin
              Bigarray.Array2.set
                my_output
                (j)
                (i)
                (Bigarray.Array2.get
                   my_input
                   ( y )
                   ( x ));
            end
          else
            begin
              Bigarray.Array2.set
                my_output
                (j)
                (i)
                (Int32.of_int 255);
            end
      done;
    done;
  Transforme.matrix_to_surf my_output

(*
 ** Rotation output optimized:
 * A = width in ; l = width out
 * B = height in ; L = height out
 * alpha an angle;
 * then we have with thales theorem and trigo simplification
 *
 * L = (cos(alpha)*B - sin(alpha)*A) / (cos(2alpha)) ; L= lo
 * l = (cos(alpha)*A - sin(alpha)*B) / (cos(2alpha)) ; l= la
 *
 * For your information there is a problem with a negative angle
 *)
let optimized surf =
  let (height,width,pitch) = Surface.dim surf in
    print_string ("this is height: "^soi(height)^"\n");
    print_string ("this is width: "^soi(width)^"\n");
    print_string ("this is angle: "^sof(!angle)^"\n");
  let a = foi(width) in
  let b = foi(height) in
  let lo = (cos(!angle)*.b -. sin(!angle)*.a) /. (cos(2.*.(!angle))) in
  let la = (cos(!angle)*.a -. sin(!angle)*.b) /. (cos(2.*.(!angle))) in
      print_string ("this is heightout: "^sof(lo)^"\n");
      print_string ("this is widthout: "^sof(la)^"\n");
  let hypot = hypotenuse surf  in
  let center = hypot / 2 in
  let cx = (center - width/2) in
  let cy = (center - height/2) in
    (*middle of the big matrix*)
  let my_output = Transforme.bigarray2 hypot hypot in
  let my_input = Transforme.surf_to_matrix surf in
    for i=0 to (hypot - 1) do
      for j=0 to (hypot - 1) do
        let (x,y) = inverse_int (i - center) (j - center) !angle in
        let (x,y) = (x + center - cx,y + center - cy) in
          if (is_in_rect x y width height) then
            begin
              Bigarray.Array2.set
                my_output
                (j)
                (i)
                (Bigarray.Array2.get
                   my_input
                   ( y )
                   ( x ));
            end
          else
            begin
              Bigarray.Array2.set
                my_output
                (j)
                (i)
                (Int32.of_int 255);
            end
      done;
    done;
  Transforme.matrix_to_surf my_output