from BeautifulSoup import BeautifulSoup as soup

title = 'Line'
scripts = [ '%s.js' % x for x in 'lib/jquery lib/less line'.split() ]
less = [ 'line.less' ]

html = soup('<html>').html

head = soup('<head>').head
html.append(head)

title_el = soup('<title>').title
head.append(title_el)
title_el.append(title)

for src in less:
  link = soup('<link>').link
  link['rel'] = 'stylesheet/less'
  link['type'] = 'text/css'
  link['href'] = src
  head.append(link)

for src in scripts:
  script = soup('<script/>').script
  script['src'] = src
  script['type'] = 'text/javascript'
  head.append(script)

print(html.prettify())
