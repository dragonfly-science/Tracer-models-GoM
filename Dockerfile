FROM docker.dragonfly.co.nz/dragonverse-18.04:2020-06-04
MAINTAINER philipp@dragonfly.co.nz

RUN Rscript -e "install.packages('denstrip');devtools::install_github('Philipp-Neubauer/fastinR/fastinR', ref='stan');"