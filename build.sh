#!/bin/bash

set -ex

Rscript -e "brms:::eval_silent(devtools::install_github('Philipp-Neubauer/fastinR/fastinR', ref='stan'));rmarkdown::render('analysis.Rmd')"

cp *.html /output/
cp *.html /publish/
