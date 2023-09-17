open Cmdliner

let cmd =
  let doc = "a CLI to manage common workflows with jira" in
  let man =
    [ `S Manpage.s_bugs; `P "Email bug reports to <bugs@example.org>" ]
  in
  let info = Cmd.info "jira" ~version:"0.0.1" ~doc ~man in
  Cmd.group info [Commands.progress_cmd; Commands.review_cmd]

let () = exit (Cmd.eval cmd)
