let get_authentication_headers (config : Config.t) =
  let open Shared in
  let open Cohttp in
  Header.init () |> fun h ->
  Header.add_authorization h
    (`Basic (config.auth.user_mail, config.auth.user_token))

let get_card code =
  let open Shared in
  let* config = Config.config () in
  let headers = get_authentication_headers config in
  let url =
    Printf.sprintf "%s/rest/api/2/issue/%s-%s" config.prefixes.url_prefix
      config.prefixes.card_prefix code
  in
  Result.ok (Http.get ~headers url |> Yojson.Safe.from_string)

let get_card_content code =
  let open Shared in
  let open Yojson.Safe.Util in
  let* card_content = get_card code in
  let description =
    card_content |> member "fields" |> member "description" |> to_string
  in
  Result.ok description

let get_card_title code =
  let open Shared in
  let open Yojson.Safe.Util in
  let* card_content = get_card code in
  let title =
    card_content |> member "fields" |> member "summary" |> to_string
  in
  Result.ok title
