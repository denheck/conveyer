open Core.Std
open Cow

let (/^) a b = Filename.concat a b

let parse_markdown markdown = 
  markdown
  |> Omd.of_string
  |> Omd.to_html

let parse_file filename filepath contents = 
  let () = Unix.mkdir_p filepath in
    Out_channel.write_all (filepath /^ filename) (parse_markdown contents)

let command = 
  Command.basic 
    ~summary:"Conveyer static site generator"
    Command.Spec.(
      empty
      +> flag "-s" (required file) ~doc:"Source path"
      +> flag "-d" (required file) ~doc:"Destination path"
    )
    (fun source destination () -> Directory_tree.walk_files parse_file (Directory_tree.make_file_tree source) destination)

let () = Command.run command
