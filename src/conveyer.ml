open Core.Std
open Cow

let parse_markdown markdown = 
  markdown
  |> Omd.of_string
  |> Omd.to_html

let parse_file file =
  In_channel.read_all file
  |> parse_markdown

let (/^) a b = Filename.concat a b

let list_files directory =
  Sys.readdir directory
  |> Array.to_list

let generate directory = 
  list_files directory
  |> List.map ~f:(fun file -> Out_channel.write_all ("tmp/destination" /^ file) (parse_file (directory /^ file)))

let () = ignore(generate "tmp/source")
