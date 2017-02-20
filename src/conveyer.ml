open Core.Std

let () = Printf.printf "%s" (In_channel.read_all "tmp/source/index.md")
