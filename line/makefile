all: lib line.js line.html
.PHONY: lib
lib:
	make -C lib
line.js: *.coffee
	coffee -c *.coffee
line.html: html.py
	python html.py > line.html
clean:
	rm -f *.js *.html *.pyc