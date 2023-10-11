let mount_cmd ~doc ~name ~cmd =
  let open Cmdliner in
  let info = Cmd.info name ~doc in
  let term = Term.(const cmd $ const ()) in
  Cmd.v info term

let pr_title () = print_endline "pr_title command"
let status () = print_endline "status command"
let view () = print_endline "view command"
let open_card () = print_endline "open_card command"
let progress () = print_endline "progress command"
let review () = print_endline "review command"

let pr_title_cmd =
  mount_cmd
    ~doc:
      "This command print out the title of the current card following a github \
       pull request pattern"
    ~name:"pr_title" ~cmd:pr_title

let status_cmd =
  mount_cmd ~doc:"This command print out which column the current card is"
    ~name:"status" ~cmd:status

let open_card_cmd =
  mount_cmd ~doc:"This command open the current card on the available browser"
    ~name:"open" ~cmd:open_card

let progress_cmd =
  mount_cmd
    ~doc:"This command move a particular jira card to\nthe progress column"
    ~name:"progress" ~cmd:progress

let review_cmd =
  mount_cmd
    ~doc:"This command move a particular jira card to\nthe review column"
    ~name:"review" ~cmd:review
