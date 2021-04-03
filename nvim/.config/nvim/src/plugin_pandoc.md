# Pandoc

## Configuration

```viml
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#mode = ["syntax"]

let g:pandoc#keyboard#use_default_mappings = 1
"let g:pandoc#modules#enabled = ["formatting", "folding", "keyboard", "lists", "references", "styles", "sections", "links", "checkboxes"]
let g:pandoc#formatting#mode = "h"
```

<!-- vim: set ft=vim: set conceallevel=0-->
