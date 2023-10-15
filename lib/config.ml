type auth = { user_mail : string; user_token : string; profile_id : string }
[@@deriving yojson]

type prefixes = { card_prefix : string; url_prefix : string }
[@@deriving yojson]

type git = { feature_tag : string; fix_tag : string } [@@deriving yojson]
type t = { auth : auth; prefixes : prefixes; git : git } [@@deriving yojson]

let read_and_parse_file filename =
  try
    let ic = open_in filename in
    let content = really_input_string ic (in_channel_length ic) in
    close_in ic;
    Yojson.Safe.from_string content
  with
  | Sys_error msg -> failwith ("Cannot open file: " ^ msg)
  | Yojson.Json_error msg -> failwith ("Cannot parse JSON: " ^ msg)

let config () =
  let path = Printf.sprintf "%s/.jira_config.json" (Sys.getenv "HOME") in
  of_yojson (read_and_parse_file path)
