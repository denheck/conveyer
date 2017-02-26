type t

exception UnkownFileType of string

val walk_files : (string -> string -> string -> 'a) -> t -> string -> unit

val make_file_tree : string -> t

