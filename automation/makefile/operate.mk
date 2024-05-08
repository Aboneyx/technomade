.PHONY: first-run clean splash prepare icon google-localizations setup format clean version doctor deep-clean install-pods

first-run: prepare run

splash: pub-get
	@echo "* Generating Splash screens *"
	@flutter pub run flutter_native_splash:create

# Prepares the application for the first run.
#
# Fetches latest dependencies, and generates code, icon and splash screen.
prepare: pub-get gen-build-delete icon splash
	@echo "* Prepared the application *"

icon: pub-get
	@echo "* Generating app icons *"
	@flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml

google-localizations:
	@echo "* Getting dependencies for google localizer *"
	@dart pub get --directory=./tool/google_localizer
	@echo "* Generating automated localizations *"
	@dart ./tool/google_localizer/main.dart "./lib/src/core/l10n/"

format:
	@dart fix --apply .
	@dart format -l 80 --fix .

setup:
	@echo "* Getting dependencies for setup tool *"
	@dart pub get --directory=./tool/setup_clone
	@echo "* Setting up the project *"
	@dart ./tool/setup_clone/main.dart $(NAME)

clean:
	@echo "* Cleaning the project *"
	@grind delete-flutter-artifacts
	@grind clean
	@git clean -d
	@make pub-get

version:
	@flutter --version

doctor:
	@flutter doctor

deep-clean:
	@echo "* Performing a deep clean *"
	@echo "* Running flutter clean *"
	@flutter clean
	@echo "* Cleaning iOS specific files *"
	@cd ios; rm Podfile.lock
	@make pub-get
	@make install-pods

install-pods: 
	@echo "Opening IOS Folder"
	@cd ios; arch -x86_64 pod install