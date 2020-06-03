#!/bin/bash

set -ex

Rscript -e "rmarkdown::render('analysis.Rmd')"

cp *.html /output/
cp *.html /publish/
