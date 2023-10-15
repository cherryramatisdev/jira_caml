(lang dune 3.10)

(name jira_caml)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name jira_caml)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
  cohttp-lwt-unix
  ocaml
  yojson
  ppx_deriving
  ppx_deriving_yojson
  dune
  cmdliner)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
