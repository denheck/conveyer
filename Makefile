default: main

main: main.native

test: 
		ocamlbuild -use-ocamlfind -pkgs alcotest -I test/ feature.native

%.native: 
	    ocamlbuild -no-hygiene -use-ocamlfind $@
	    mv $@ $*

.PHONY: test default
