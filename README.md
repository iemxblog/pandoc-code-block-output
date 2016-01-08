# Description
This program is a pandoc filter that runs all the haskell code blocks in a document, and integrates their outputs just below them. It can be useful to write the documentation of a library.

# Building the executable

Make sure you have install the Haskell Platform.

```console
git clone https://github.com/iemxblog/pandoc-code-block-output
cd pandoc-code-block-output
cabal sandbox init
cabal install --only-dependencies
cabal build
```

The executable is there : ./dist/build/pandoc-code-block-output/pandoc-code-block-output

# How to use it

Write a Markdown file with a haskell code block in it then produce for example a PDF from it :
```console
pandoc -s file.md -o file.pdf --filter ./pandoc-code-block-output
```

# Example

An example is included with the code : example.md
It contains a hello world program in haskell, and a Makefile to build a pdf from it :
```console
cat example.md
make
evince example.pdf
```
