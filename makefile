source-directory=`pwd`
src=$(source-directory)/volume.sh
target-directory=~/.local/bin
target=$(target-directory)/volume.sh

install: clean
	mkdir -p $(target-directory)
	ln -s $(src) $(target)
clean:
	rm -f $(target)

.PHONY: install clean

