.PHONY: build-android build-web build-ios

build-android: clean
	@echo "Building Android APK"
	@flutter build apk --no-pub --no-shrink

build-web: clean
	@echo "Building Web app"
	@flutter build web --dart-define=FLUTTER_WEB_USE_SKIA=true --no-pub --no-source-maps --pwa-strategy offline-first

build-ios: clean
	@echo "Building iOS IPA"
	@flutter build ipa --no-pub

test-apk: 
	@echo "Build test Android APK"
	@flutter build apk --split-per-abi

fv-run: 
	@echo "Run project with flavors"
	@flutter run --flavor $(p)

prod-apk:
	@echo "Build apk with prod flavor"
	@flutter build apk --flavor prod -t lib/main_prod.dart --release

dev-apk:
	@echo "Build apk with dev flavor"
	@flutter build apk --flavor dev -t lib/main_dev.dart --release

prod-appbundle:
	@echo "Build appbundle with prod flavor"
	@flutter build appbundle --flavor prod -t lib/main_prod.dart

dev-appbundle:
	@echo "Build appbundle with dev flavor"
	@flutter build appbundle --flavor dev -t lib/main_dev.dart

dev-run:
	@echo "Run dev flavor"
	@flutter run --flavor dev -t lib/main_dev.dart