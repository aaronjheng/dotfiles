cleanup:
	find . -name '*.DS_Store' -exec rm --force {} +

.PHONY: cleanup