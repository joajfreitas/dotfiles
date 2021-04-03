#!/usr/bin/env python3

import click
import sys
import os

import re
import markdown

from loguru import logger
from pathlib import Path
from pprint import pprint

from typing import *

visited = []

extensions = [
    "markdown.extensions.fenced_code",
    "markdown.extensions.codehilite"]


def weave_lines(lines: List[str], root: Path, filename: Path) -> str:
    if filename in visited:

        return ""
    visited.append(filename)

    logger.info(f"{root} {filename}")
    link_regex = re.compile("(\((?P<link>[\w / .]+)\))+")

    vimL = ""

    comment_block = False
    viml_block = False

    for line in lines:
        if "```viml" in line:
            viml_block = True
            continue

        if "```" in line:
            if viml_block == True:
                viml_block = False
            else:
                comment_block = not comment_block

            continue

        if comment_block == True:
            continue

        if viml_block:
            vimL += line
        else:
            m = link_regex.search(line)
            if m is not None:
                link = m.group("link")
                link_path = root / Path(link)
                if link_path.exists():
                    logger.info(f"link {link_path}")
                    with link_path.open("r") as f:
                        vimL += weave_lines(f.readlines(), root, link)
                else:
                    logger.error(f"link path not found: {link_path} {line}")
            if line[0:4] == "    ":
                vimL += line[4:]
            if line[0:2] == "  ":
                vimL += line[2:]
            if line[0] == "\t":
                vimL += line[1:]

    return vimL


@click.command("weave")
@click.argument("path", type=Path)
@click.argument("out", type=Path)
def weave(path: Path, out: Path):
    """Generate vim code."""


    markdown_files = path.glob("*.md")

    if path/Path("vimrc.md") not in markdown_files:
        logger.error("missing vimrc.md")
        return

    with (path / Path("vimrc.md")).open("r") as f:
        lines = f.readlines()

    vimrc = weave_lines(lines, path, "vimrc.md")

    with (out / Path("init.vim")).open("w") as f:
        f.write(vimrc)


@click.command("web")
@click.argument("path", type=Path)
@click.argument("output", type=Path)
def web(path: Path, output: Path):
    """Generate html documentation."""

    preamble = """
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="highlight.css">
"""

    markdown_files = path.glob("*.md")
    for md in markdown_files:
        with open(md) as f:
            html = markdown.markdown(f.read(), extensions=extensions)

        out = output / Path(md).with_suffix(".tmp").relative_to(path)


        with open(out, "w") as f:
            f.write(preamble + html)

        html_path = out.with_suffix(".html")
        os.system(f"sed 's/.md/.html/g' {out} > {html_path}")

        #logger.info(
        #    f"pandoc -s --highlight-style pygments --lua-filter=link-to-html.lua --css=pandoc-github.css {md} -o {out}"
        #)
        #os.system(
        #    f"pandoc -s --highlight-style pygments --lua-filter=link-to-html.lua --css=pandoc-github.css {md} -o {out}"
        #)


@click.group()
def main():
    return


main.add_command(weave)
main.add_command(web)

if __name__ == "__main__":
    main()
