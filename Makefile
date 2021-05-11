.POSIX:

docs:
	${SHELL} scripts/get-docs.sh
	${SHELL} scripts/update-docs.sh

.PHONY: docs