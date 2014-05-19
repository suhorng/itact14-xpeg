open Prelude;;

(* jpeg parse *)

(* TODO
 * - huffman tables
 * - quantisation table
 * - SOF (start of fragment): height, width, components
 * - SOS (start of segment) : dctable, actable, ncomponents *)

let jpeg_raw () =
  let fin = open_in_bin "hd.jpg" in
  let len = in_channel_length fin in
  let data = String.create len in
  really_input fin data 0 len;
  close_in fin;
  data;;

let jpeg_segmenting raw_data =
  let [ch_ff; ch_00; ch_EOI] = List.map char_of_int [0xff; 0x00; 0xd9] in
  let rec find_candidates acc start_idx =
    try let idx = String.index_from raw_data start_idx ch_ff
        in if raw_data.[idx+1] == ch_EOI
             then List.rev acc
             else find_candidates (idx::acc) (idx + 1)
    with Not_found -> List.rev acc
  in List.tl (find_candidates [] 0)
  |> List.filter (fun i -> raw_data.[i+1] <> ch_00)
  |> List.map (fun i -> (int_of_char raw_data.[i+1], i));;

(* TODOs *)
let jpeg_parse_dqt dqt_idx = ();;
let jpeg_parse_dht dht_idx = ();;
let jpeg_parse_sof sof_idx = ();;
let jpeg_parse_sos sof_idx = ();;
