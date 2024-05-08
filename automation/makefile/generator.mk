.PHONY: gen-build gen-build-delete gen-clean gen-watch doc

gen-build: pub-get
	@echo "* Running build runner *"
	@dart run build_runner build

gen-build-delete: pub-get
	@echo "* Running build runner with deletion of conflicting outputs *"
	@dart run build_runner build --delete-conflicting-outputs

gen-clean:
	@echo "* Cleaning build runner *"
	@dart run build_runner clean

gen-watch:
	@echo "* Running build runner in watch mode *"
	@dart run build_runner watch

doc:
	@dart doc