open Core.Std
open Cow

let (/^) a b = Filename.concat a b

let write_html filename filepath contents =
  let () = Unix.mkdir_p filepath in
    let output_filename = (Filename.chop_extension (filepath /^ filename)) ^ ".html" in
      Out_channel.write_all output_filename contents

let generate_site source destination render_template =
  Directory_tree.walk_files
    (fun filename filepath contents ->
       contents
       |> Parser.parse
       |> render_template "{{body}}"
       |> write_html filename filepath
    )
    (Directory_tree.make_file_tree source)
    destination

let command =
  Command.basic
    ~summary:"Conveyer static site generator"
    Command.Spec.(
      empty
      +> flag "-s" (required file) ~doc:"Source path"
      +> flag "-d" (required file) ~doc:"Destination path"
      +> flag "-t" (required file) ~doc:"Layout template path"
    )
    (fun source destination template () ->
       let template = Template.read_all template in
         let render_template = Template.embed template in
           ignore (generate_site source destination render_template))

let () = Command.run command
