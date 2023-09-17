open Cmdliner

let progress () = print_endline "progress command"

let progress_cmd =
        let doc = "This command move a particular jira card to the progress
        column and create a new git branch using the correct pattern" in
        let info = Cmd.info "progress" ~doc in
        let term = Term.(const progress $ const ()) in
        Cmd.v info term

let review () = print_endline "review command"

let review_cmd =
        let doc = "This command move a particular jira card to the review
        column and create a new github pull request using the gh cli tool" in
        let info = Cmd.info "review" ~doc in
        let term = Term.(const review $ const ()) in
        Cmd.v info term
