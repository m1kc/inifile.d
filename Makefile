all:
	dmd -w -wi -O -D test.d inifile.d -oftest

nodocs:
	dmd -w -wi -O test.d inifile.d -oftest

clean:
	rm -f test *.o test.ini *.html
