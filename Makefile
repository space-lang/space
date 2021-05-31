.POSIX:

# ====== Building ======

build:        		# Compiles Compiler
	dune build

deps:			    # Handles Dependencies
	opam update
	opam install
	
# ====== Temp CLI build targets ======
cli:
	cd src/cli
	./build.sh

clideps:
	cd src/cli
	opam update

# ====== Misc ======

clean:
	rm -rf _build

# ====== Docs ======

docs:
	${SHELL} scripts/get-docs.sh
	${SHELL} scripts/update-docs.sh

upsub:
	${SHELL} scripts/get-docs.sh
	${SHELL} scripts/update-docs.sh
	git add docs
	git commit -m "refactor: updated submodules"
	git push

.PHONY: docs, upsub, clean, space
