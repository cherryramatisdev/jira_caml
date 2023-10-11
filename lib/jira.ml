open Lwt
open Cohttp_lwt

let () =
  let headers = Header.init () in
  let* response =
    Lwt.return
      (Client.get ~headers
         (Uri.of_string "https://jsonplaceholder.typicode.com/posts/1"))
  in
  print_endline response
