let extract_jira_card_from_git_branch prefix =
  let open Shared in
  let open Str in
  let branch_name =
    Shell.execute_and_capture_output "git rev-parse --abbrev-ref HEAD"
    |> fun str -> str |> String.trim
  in
  let regex = Printf.sprintf ".*%s-\\([0-9]+\\)" prefix |> regexp in
  match string_match regex branch_name 0 with
  | true -> matched_group 1 branch_name
  | _ -> ""
