open Core.Std
open Cow

let parse_markdown markdown = 
  markdown
  |> Omd.of_string
  |> Omd.to_html

let (/^) a b = Filename.concat a b

let destination = "tmp/destination"
let source = "tmp/source"

let parse_file filename filepath contents = 
  let () = Unix.mkdir_p filepath in
    Out_channel.write_all (filepath /^ filename) (parse_markdown contents)

let () = ignore (Directory_tree.walk_files parse_file (Directory_tree.make_file_tree source) destination)
