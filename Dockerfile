#Dockerfile centos-rserve
# 选择一个已有的os镜像作为基础
FROM wuyl/centos-with-rbase:latest

# 镜像的作者
MAINTAINER wuyl

# 安装R语言库（install packages）
RUN echo 'install.packages("Rserve",,"http://rforge.net/",type="source")' > /tmp/packages.R \
    && Rscript /tmp/packages.R
# Popular data science packages
RUN echo 'install.packages(c("Rserve", "rJava", "NbClust", "ape", "xlsx"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages2.R \
   && Rscript /tmp/packages2.R

# 暴露6311端口供Rserve使用
EXPOSE 6311

# 加载包并启动rserve
ENTRYPOINT R -e "\
library(Rserve); \
library(rJava); \
library(NbClust); \
library(ape); \
library(xlsx); \

ENTRYPOINT R -e "\Rserve::run.Rserve(remote=TRUE)"