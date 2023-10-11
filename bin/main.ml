let cmd =
  let open Cmdliner in
  let doc = "a CLI to manage common workflows with jira" in
  let man =
    [ `S Manpage.s_bugs; `P "Email bug reports to <bugs@example.org>" ]
  in
  let info = Cmd.info "jira" ~version:"0.0.1" ~doc ~man in
  let open Commands in
  Cmd.group info [pr_title_cmd; status_cmd; open_card_cmd; progress_cmd; review_cmd]

let () = exit (Cmdliner.Cmd.eval cmd)
