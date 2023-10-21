let view card_index =
  let open Lib__Shared in
  let open Lib__Jira in
  let* description = get_card_content card_index in
  print_endline description;
  Result.ok description

let progress card_index =
  Printf.printf "progress command %s" card_index |> print_newline;
  Result.ok card_index

let review card_index =
  Printf.printf "review command %s" card_index |> print_newline;
  Result.ok card_index

let open_card card_index =
  let open Lib__Shared in
  let* config = Lib.Config.config () in
  let url_card =
    Printf.sprintf "%s/browse/%s-%s" config.prefixes.url_prefix
      config.prefixes.card_prefix card_index
  in
  let open_cmd = get_open_cmd () in
  let _ = Printf.sprintf "%s %s" open_cmd url_card |> Sys.command in
  Result.ok url_card

let status card_index =
  let open Lib__Shared in
  let open Lib__Jira in
  let* status = get_card_status card_index in
  print_endline status;
  Result.ok status

let pr_title card_index =
  let open Lib__Shared in
  let open Lib__Jira in
  let* title = get_card_title card_index in
  print_endline title;
  Result.ok title
