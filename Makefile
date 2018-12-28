index.html: elm.js

elm.js: $(wildcard src/*.elm)
	elm make src/Main.elm --output=public/elm.js
