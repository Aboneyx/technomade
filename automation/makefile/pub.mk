.PHONY: pub-get pub-outdated pub-upgrade pub-upgrade-major

# Fetches latest dependencies using Flutter Version Manager.
pub-get:
	@echo "* Getting latest dependencies *"
	@flutter pub get

pub-upgrade:
	@echo "* Upgrading dependencies *"
	@flutter pub upgrade

pub-upgrade-major:
	@echo "* Upgrading dependencies --major-versions *"
	@flutter pub upgrade --major-versions

pub-outdated: pub-upgrade
	@echo "* Checking for outdated dependencies *"
	@flutter pub outdated