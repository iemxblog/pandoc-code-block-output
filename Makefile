all: example.pdf

./dist/build/pandoc-code-block-output/pandoc-code-block-output:
	cabal build

example.pdf: example.md ./dist/build/pandoc-code-block-output/pandoc-code-block-output
	pandoc -s example.md -o example.pdf --filter ./dist/build/pandoc-code-block-output/pandoc-code-block-output

clean:
	rm -f example.pdf
