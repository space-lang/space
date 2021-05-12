.POSIX:

docs:
	${SHELL} scripts/get-docs.sh
	${SHELL} scripts/update-docs.sh

upsub:
	${SHELL} scripts/get-docs.sh
	${SHELL} scripts/update-docs.sh
	git add docs
	git commit -m "refactor: updated submodules"
	git push

.PHONY: docs, upsub