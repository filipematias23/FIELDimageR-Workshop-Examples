FROM rocker/binder:3.6.3

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
  
## run any install.R script we find
#RUN if [ -f install.R ]; then R --quiet -f install.R; fi
## Install R packages one by one to cache the ones that work
RUN Rscript -e 'install.packages(c("sp", "raster", "rgdal", "ggplot2", "agricolae", "reshape2", "devtools", "ggrepel", "lme4", "plyr", "DescTools", "doParallel", "parallel", "foreach", "maptools", "spatialEco", "attempt", "igraph", "config", "BiocManager")repos="https://cloud.r-project.org")'
RUN Rscript -e 'BiocManager::install("EBImage")'
RUN Rscript -e 'devtools::install_github("filipematias23/FIELDimageR", dependencies=FALSE)'
