# Dockerfile for OpenCV with CUDA C++, Python 2.7 / 3.6 development 
# Pulling CUDA-CUDNN image from nvidia
FROM mlamarre/cuda9.1-opencv3.4.0-dev
MAINTAINER Mathieu Lamarre <mathieu.lamarre@gmail.com>

ENV SUITESPARSE_VERSION 5.1.2
# Original source URL, however this server is slow (or blacklists IP after too much downloads)
# http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz

WORKDIR /
RUN mkdir /temp \
&& wget https://launchpad.net/ubuntu/+archive/primary/+files/suitesparse_${SUITESPARSE_VERSION}.orig.tar.gz -O /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& wget https://raw.githubusercontent.com/mlamarre/docker-cuda-opencv-suitesparse/master/SuiteSparse_config_MKL_TBB.patch -O /temp/SuiteSparse_config_MKL_TBB.patch\
&& tar -xzvf /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& cd SuiteSparse/SuiteSparse_config\
&& patch < /temp/SuiteSparse_config_MKL_TBB.patch\
&& cd /SuiteSparse\
&& rm -rf /temp\
&& make MKLROOT=/opt/conda/envs/ocvpy3 TBB="-ltbb -DSPQR_CONFIG=-DHAVE_TBB" INSTALL=/usr/local -j$(nproc) install\
&& cd /\
&& rm -rf SuiteSparse

RUN ldconfig -v