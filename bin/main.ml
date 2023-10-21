let help_message =
  "\n\
   Available commands:\n\n\
   - progress <code>: Send the jira card informed by the code to progress \
   column and create a new branch for it\n\
   - review <code>: Send the jira card informed by the code to review column \
   and create a new pull request for it\n\
   - status <code>: Print the current column for the jira card informed by the \
   code\n\
   - view <code>: Print the description for the jira card informed by the code\n\
   - pr_title <code>: Print the title for the jira card informed by the code\n\
   - open <code>: Open the current card informed by the code on the browser\n"

let get_help () = print_endline help_message

let parse_cmd_with_jira_code rest (cb : string -> (string, string) result) =
  match rest with
  | subcmd :: _ -> cb subcmd
  | _ ->
      get_help ();
      Result.ok help_message

let parse_cmd (cmd : string) (rest : string list) =
  let open Commands in
  match cmd with
  | "progress" -> parse_cmd_with_jira_code rest progress
  | "status" -> parse_cmd_with_jira_code rest status
  | "view" -> parse_cmd_with_jira_code rest view
  | "open" -> parse_cmd_with_jira_code rest open_card
  | "review" -> parse_cmd_with_jira_code rest review
  | "pr_title" -> parse_cmd_with_jira_code rest pr_title
  | _ ->
      get_help ();
      Result.ok help_message

let () =
  let args = Array.to_list Sys.argv in
  match args with
  | [] -> get_help ()
  | _ :: cmd :: rest -> (
      match parse_cmd cmd rest with Ok _ -> () | Error _ -> get_help ())
  | _ -> get_help ()
