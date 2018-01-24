# Dockerfile for OpenCV with CUDA C++, Python 2.7 / 3.6 development 
# Pulling CUDA-CUDNN image from nvidia
FROM mlamarre/cuda9.1-opencv3.4.0-dev
MAINTAINER Mathieu Lamarre <mathieu.lamarre@gmail.com>

ENV SUITESPARSE_VERSION 5.1.2

WORKDIR /
RUN mkdir /temp \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz -O /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& wget https://raw.githubusercontent.com/mlamarre/docker-cuda-opencv-suitesparse/master/SuiteSparse_config_MKL_TBB.patch -O /temp/SuiteSparse_config_MKL_TBB.patch\
&& tar -xzvf /temp/SuiteSparse-${SUITESPARSE_VERSION}.tar.gz\
&& cd SuiteSparse/SuiteSparse_config\
&& patch < /temp/SuiteSparse_config_MKL_TBB.patch\
&& cd /SuiteSparse\
&& rm -rf /temp\
&& export LIBRARY_PATH=$LIBRARY_PATH/opt/conda/envs/ocvpy3/lib\
&& make MKLROOT=/opt/conda/envs/ocvpy3 TBB="-ltbb -DSPQR_CONFIG=-DHAVE_TBB" INSTALL=/opt/SuiteSparse -j$(nproc) install\
&& make purge
