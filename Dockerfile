# Dockerfile for OpenCV with CUDA C++, Python 2.7 / 3.6 development 
# Pulling CUDA-CUDNN image from nvidia
FROM mlamarre/cuda9.1-opencv3.4.0-dev
MAINTAINER Mathieu Lamarre <mathieu.lamarre@gmail.com>

ENV SUITESPARSE_VERSION 5.1.0

WORKDIR /
RUN mkdir /temp \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz -O /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& tar -xzvf /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& rm -rf temp