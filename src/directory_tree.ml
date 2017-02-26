open Core.Std

let (/^) a b = Filename.concat a b

exception UnkownFileType of string

type file_tree = 
  | File of string * string
  | Directory of string * file_tree list

let rec walk_files fn directory_tree path =
  match directory_tree with
  | File (name, contents)        -> ignore (fn name path contents)
  | Directory (name, file_trees) -> ignore (List.map ~f:(fun directory_tree -> walk_files fn directory_tree (path /^ name)) file_trees)


let rec make_file_tree path =
  let name = Filename.basename path in
    match Sys.is_directory path with
    | `Yes -> Directory (name, (List.map ~f:(fun name -> make_file_tree (path /^ name)) (Array.to_list (Sys.readdir path))))
    | `No -> File (name, In_channel.read_all path)
    | _   -> raise (UnkownFileType ("Unknown or missing file " ^ path))
