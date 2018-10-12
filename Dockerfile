#Dockerfile centos-rserve
# 选择一个已有的os镜像作为基础
FROM wuyl/centos-with-rbase:2.0

# 镜像的作者
MAINTAINER wuyl

# 暴露6311端口供Rserve使用
EXPOSE 6311

ENTRYPOINT R -e "Rserve::run.Rserve(remote=TRUE)"