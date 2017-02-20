default: main

main: main.native

%.native: 
	    ocamlbuild -no-hygiene -use-ocamlfind $@
	    mv $@ $*

.PHONY: test default
