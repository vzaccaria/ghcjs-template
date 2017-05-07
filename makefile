
SOURCE=Main.hs

all: js/all.js

js/all.js: $(SOURCE)
	stack build
	mkdir -p js
	cp -r .stack-work/dist/x86_64-linux/Cabal-1.24.0.0_ghcjs/build/starterApp/starterApp.jsexe/all.js $@


# # Minifying all.js file using the closure compiler:
# cd js
# ccjs all.js --compilation_level=ADVANCED_OPTIMIZATIONS > all.min.js

# # OPTIONAL: zipping, to see the actual transferred size of the app:
# zopfli all.min.js
