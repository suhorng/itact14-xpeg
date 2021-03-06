let flip f x y = f y x;;

module L = struct

  include List;;

  let sum xs = fold_left (+) 0 xs;;

  let rec range begin_ end_ = if begin_ < end_
                                then begin_ :: range (begin_ + 1) end_
                                else [];;

  let maximum (x :: xs) =
    let rec max_rec acc = function
        [] -> acc
      | (y :: ys) -> max_rec (max y acc) ys
    in max_rec x xs;;

  let rec transpose = function
      [] -> []
    | xs :: xss -> let row1 = map hd xss in
                   let submatrix = transpose (map tl xss) in
                   let cons a b = a::b in
                   map2 cons xs (row1::submatrix);;

  let scan_left f z xs =
    let rec scan_left_acc z acc = function
        [] -> rev (z::acc)
      | x::xs -> let w = f z x in scan_left_acc w (z::acc) xs
    in scan_left_acc z [] xs;;

  let rec map3 f xs ys zs = match (xs, ys, zs) with
      ([], [], []) -> []
    | (x::xs, y::ys, z::zs) -> f x y z::map3 f xs ys zs
    | _ -> raise (Failure "map3: Invalid argument");;

end

module A = struct

  include Array;;

  let transpose mat =
    flip iteri mat (fun i row ->
      flip iteri row (fun j m_ij ->
        if i < j then begin
          (* swap mat[i][j] and mat[j][i] *)
          let t = mat.(j).(i) in
          mat.(j).(i) <- m_ij;
          row.(j) <- t
        end));;

end
