let get_card_content code =
  let open Shared in
  let open Cohttp in
  let* config = Config.config () in
  let headers =
    Header.init () |> fun h ->
    Header.add_authorization h
      (`Basic (config.auth.user_mail, config.auth.user_token))
  in
  let url =
    Printf.sprintf "%s/rest/api/2/issue/%s-%s" config.prefixes.url_prefix
      config.prefixes.card_prefix code
  in
  let open Yojson.Safe.Util in
  let description =
    Http.get ~headers url |> Yojson.Safe.from_string |> member "fields"
    |> member "description" |> to_string
  in
  Result.ok description
