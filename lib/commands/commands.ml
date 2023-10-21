let view cmd =
  let open Lib__Shared in
  let open Lib__Jira in
  let* description = get_card_content cmd in
  print_endline description;
  Result.ok description

let progress cmd =
  Printf.printf "progress command %s" cmd |> print_newline;
  Result.ok cmd

let review cmd =
  Printf.printf "review command %s" cmd |> print_newline;
  Result.ok cmd

let open_card cmd =
  Printf.printf "open command %s" cmd |> print_newline;
  Result.ok cmd

let status cmd =
  Printf.printf "status command %s" cmd |> print_newline;
  Result.ok cmd

let pr_title cmd =
  let open Lib__Shared in
  let open Lib__Jira in
  let* title = get_card_title cmd in
  print_endline title;
  Result.ok title
