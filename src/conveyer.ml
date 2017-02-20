open Core.Std
open Cow

let parse_markdown markdown = 
  markdown
  |> Omd.of_string
  |> Omd.to_html

let generate directory = 
  let source = In_channel.read_all (directory ^ "/index.md") in
    let parsed_source = parse_markdown source in
    Out_channel.write_all ~data:parsed_source "tmp/destination/index.html"

let () = generate "tmp/source"
