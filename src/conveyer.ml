open Core.Std

let generate directory = 
  let source = In_channel.read_all (directory ^ "/index.md") in
  Out_channel.write_all ~data:source "tmp/destination/index.html"

let () = generate "tmp/source"
