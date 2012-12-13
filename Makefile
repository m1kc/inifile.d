all:
	dmd -w -wi -O test.d inifile.d -oftest

clean:
	rm -f test test.o test.ini
