PREFIX ?= /usr/local

install:
	install -d $(PREFIX)/bin
	install -d /etc/raidmon
	install -m 755 raidmon $(PREFIX)/bin/raidmon

uninstall:
	rm -f $(PREFIX)/bin/raidmon

.PHONY: install uninstall
