#!/bin/bash

set -ex

Rscript -e "rmarkdown::render('analysis.Rmd')"

cp *.html /output/
cp *.Rdata /output/
cp *.html /publish/

s3cmd -v \
      --access_key=${AWS_ACCESS_KEY_ID} \
      --secret_key=${AWS_SECRET_ACCESS_KEY} \
      sync -r ./GoM_tracers.Rdata s3://${AWS_BUCKET}/