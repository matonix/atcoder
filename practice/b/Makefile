.PHONY: Main output
all: Main output
	diff expect output

Main:
	stack ghc --resolver ghc-7.10.3 -- -O2 Main.hs
	rm Main.hi Main.o

output:
	./Main < input > output

.PHONY: clean
clean:
	rm -f Main output