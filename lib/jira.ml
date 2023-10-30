open Shared

let get_authentication_headers (config : Config.t) =
  let open Cohttp in
  Header.init () |> fun h ->
  Header.add_authorization h
    (`Basic (config.auth.user_mail, config.auth.user_token))
  |> fun h -> Header.add h "Content-Type" "application/json"

let get_card code =
  let* config = Config.config () in
  let headers = get_authentication_headers config in
  let url =
    Printf.sprintf "%s/rest/api/2/issue/%s-%s" config.prefixes.url_prefix
      config.prefixes.card_prefix code
  in
  Http.get ~headers url |> Yojson.Safe.from_string |> Result.ok

let get_card_content code =
  let open Yojson.Safe.Util in
  let* card_content = get_card code in
  card_content |> member "fields" |> member "description" |> to_string
  |> Result.ok

let get_card_title code =
  let open Yojson.Safe.Util in
  let* card_content = get_card code in
  card_content |> member "fields" |> member "summary" |> to_string |> Result.ok

let get_card_status code =
  let open Yojson.Safe.Util in
  let* card_content = get_card code in
  card_content |> member "fields" |> member "status" |> member "name"
  |> to_string |> Result.ok

(* TODO: this is the best name? *)
type transition_t = Progress | Review
type transition_body = { id : string } [@@deriving yojson]
type move_card_body = { transition : transition_body } [@@deriving yojson]

let move_card (transition : transition_t) code =
  let open Cohttp_lwt in
  let* config = Config.config () in
  let headers = get_authentication_headers config in
  let transition_id =
    match transition with Progress -> "31" | Review -> "51"
  in
  let body =
    move_card_body_to_yojson { transition = { id = transition_id } }
    |> Yojson.Safe.to_string |> Body.of_string
  in
  let url =
    Printf.sprintf "%s/rest/api/2/issue/%s-%s/transitions"
      config.prefixes.url_prefix config.prefixes.card_prefix code
  in
  Http.post url body ~headers |> Result.ok
