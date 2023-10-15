let get url ~headers =
  let request =
    let open Cohttp_lwt_unix in
    let open Lwt in
    Client.get ~headers (Uri.of_string url) >>= fun (_, body) ->
    body |> Cohttp_lwt.Body.to_string >|= fun body -> body
  in
  Lwt_main.run request

let post url body ~headers =
  let request =
    let open Cohttp_lwt_unix in
    let open Lwt in
    Client.post ~headers ~body (Uri.of_string url) >>= fun (_, body) ->
    body |> Cohttp_lwt.Body.to_string >|= fun body -> body
  in
  Lwt_main.run request
