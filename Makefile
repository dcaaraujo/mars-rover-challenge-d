all:
	dmd instructions.d plateau.d rover.d main.d -of=mars-rover

clean:
	rm -rf mars-rover mars-rover.o mars-rover-test mars-rover-test.o

run:
	./mars-rover

test:
	dmd instructions.d plateau.d rover.d main.d -unittest -of=mars-rover-test
	./mars-rover-test
