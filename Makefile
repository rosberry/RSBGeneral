
all: config bootstrap

config:
	general config repo "rosberry/general-templates ios" --as "ios"
	general config override-plugin-input true
	general config use --executable GeneralIOs --for setup
	general config use --executable GeneralIOs --for gen

bootstrap:
	@while [ -z "$$TEMPLATES_ROOT_PATH" ] || [ ! -d "$$TEMPLATES_ROOT_PATH" ]; do \
			echo "Type path to valid swift project templates root: "; \
	    read TEMPLATES_ROOT_PATH; \
	done ; \
	(cd $$TEMPLATES_ROOT_PATH && \
	(git clone "https://github.com/rosberry/swift-project-template" || true) && \
	(cd "swift-project-template" && git checkout umaler) && \
	general bootstrap config update -t "$(shell pwd)/swift-project-template")
	general bootstrap config update --company "Rosberry"
	general bootstrap config update --firebase true
	general bootstrap config update --swiftgen true
	general bootstrap config update --licenseplist true
	echo "\n\n" | general bootstrap config update shell --add swiftgen
	echo "setup -t ios\n\n\n" | general bootstrap config update shell --add general
	echo "update\n\n\n" | general bootstrap config update shell --add fastfood
	echo "rsb_lint mode:autocorrect\n\n\n" | general bootstrap config update shell --add fastlane
	echo "install\n\nDepofile\n\n" | general bootstrap config update shell --add depo
