#!/bin/bash
# 编译 Beamer 中英文模板
xelatex -interaction=nonstopmode ${1:-slide.tex}
xelatex -interaction=nonstopmode ${1:-slide.tex}