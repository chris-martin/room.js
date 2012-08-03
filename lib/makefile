downloads=jquery.js less.js
all: $(downloads)
jquery.js:
	wget http://code.jquery.com/jquery-1.7.2.min.js -O jquery.js
less.js:
	wget http://lesscss.googlecode.com/files/less-1.3.0.min.js -O less.js
clean:
	rm -f $(downloads)