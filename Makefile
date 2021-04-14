all: docs/tutorial/poster.html docs/koika/poster.html docs/poster.css

docs/poster.css: poster.less
	lessc --strict-units=on $< $@

docs/%/:
	mkdir -p $@

docs/%/poster.css: docs/poster.css | docs/%/
	ln -f -s ../poster.css $@

docs/%/poster.html: docs/%.jinja2 poster.jinja2 docs/%/poster.css | docs/%/
	./render.py $< $@

clean:
	-rm docs/poster.css
	-rm -fr docs/*/poster.{html,css}
	-rm -fr build

poster: build/poster.html build/poster.css

build/%:
	mkdir -p build
	cp -r source/img build/img

build/poster.css: source/poster.less | build/%
	lessc --strict-units=on $< $@

build/poster.html: source/poster.jinja2 build/poster.css | build/%
	./render.py $< $@


.SECONDARY:
