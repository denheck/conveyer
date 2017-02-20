open Core.Std

let () = Out_channel.write_all "tmp/destination/index.html" (In_channel.read_all "tmp/source/index.md")
