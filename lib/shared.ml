let ( |> ) x f = f x
let ( let* ) = Result.bind
let ( let@ ) = Lwt.bind

let rec replace_word str old_word new_word =
  match String.split_on_char ' ' str with
  | [] -> ""
  | word :: rest ->
      if word = old_word then
        new_word ^ " " ^ replace_word (String.concat " " rest) old_word new_word
      else word ^ " " ^ replace_word (String.concat " " rest) old_word new_word

let remove_char str char_to_remove =
  let aux str index =
    if index >= 0 && index < String.length str then
      let before = String.sub str 0 index in
      let after = String.sub str (index + 1) (String.length str - index - 1) in
      before ^ after
    else str
  in
  try
    let index = String.index str char_to_remove in
    aux str index
  with Not_found -> str

module Shell = struct
  let execute command =
    let open Unix in
    open_process_in command

  let execute_and_capture_output command =
    let open Unix in
    try
      let in_channel = execute command in
      let output = input_line in_channel in
      close_in in_channel;
      output
    with
    | Unix_error (err, _, _) ->
        Printf.sprintf "Error executing command: %s" (error_message err)
    | End_of_file -> "No output"

  let choose_option options =
    let options_string = String.concat " or " (Array.to_list options) in
    print_endline ("Choose between " ^ options_string ^ ":");
    let rec get_input () =
      let input = read_line () in
      if Array.mem input options then input
      else (
        print_endline
          ("Invalid option. Please choose between " ^ options_string ^ ":");
        get_input ())
    in
    get_input ()
end

(* TODO: support different OSes
   maybe this could be in a separate module
*)
let get_open_cmd () = "open"
