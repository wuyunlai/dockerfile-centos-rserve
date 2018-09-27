#Dockerfile centos-rserve
# 选择一个已有的os镜像作为基础
FROM wuyl/centos-r:latest

# 镜像的作者
MAINTAINER wuyl

# 更新安装必要库
RUN yum update && yum install -y \
        libcurl4-openssl-dev \
        libssl-dev \
        libcairo-dev \
        libnlopt-dev

# 安装R语言库（install packages）
RUN echo 'install.packages("Rserve",,"http://rforge.net/",type="source")' > /tmp/packages.R \
    && Rscript /tmp/packages.R
# Popular data science packages
RUN echo 'install.packages(c("data.table", "dplyr", "plyr", "scales", "lubridate", "ggplot2", "grid", "BSDA", "cluster", "clustertend", "factoextra", "heatmaply", "NbClust", "RColorBrewer", "pandoc","ape","xlsx"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages2.R \
   && Rscript /tmp/packages2.R

# 暴露6311端口供Rserve使用
EXPOSE 6311

# 加载包并启动rserve
ENTRYPOINT R -e "\
library(Rserve); \
library(data.table); \
library(dplyr); \
library(plyr); \
library(scales); \
library(lubridate); \
library(ggplot2); \
library(grid); \
library(BSDA); \
library(cluster); \
library(clustertend); \
library(factoextra); \
library(heatmaply); \
library(NbClust); \
library(RColorBrewer); \
library(pandoc); \
library(ape); \
library(xlsx); \

ENTRYPOINT R -e "\Rserve::run.Rserve(remote=TRUE)"