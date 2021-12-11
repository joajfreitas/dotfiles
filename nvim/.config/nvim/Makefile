make:
	mkdir -p html
	literate_vim web src html
	rm -rf html/*.tmp
	literate_vim weave src .

clean:
	rm -rf html/*.html
