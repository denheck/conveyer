open Core.Std

type t = string

let embed template placeholder contents =
  Str.global_replace (Str.regexp placeholder) contents template

let read_all filename =
  In_channel.read_all filename
