ARG TensorFlow_Version=latest
ARG TensorFlow_Variants=-gpu-py3
FROM tensorflow/tensorflow:${TensorFlow_Version}${TensorFlow_Variants}
MAINTAINER Alexx Perloff "Alexx.Perloff@Colorado.edu"

# Merge in the directions to install miniconda
# Taken from https://hub.docker.com/r/continuumio/anaconda/dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y curl wget git ca-certificates cmake
#    bzip2 libglib2.0-0 libxext6 libsm6 libxrender1 mercurial subversion && \

# Install bazel
# Known Dependencies: curl
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
    apt-get update && \ 
    apt-get install -y bazel && \
    apt-get clean

# Install packages into the default python release
RUN pip install --no-cache-dir blaze cython dask gpyopt graphviz keras keras-tuner matplotlib mkl numba numpy pandas pydot pytest scikit-image scikit-learn theano energyflow PyHamcrest uproot uproot-methods

# Install libgpuarray/pygpu
# Known Dependencies: cmake, git
RUN git clone https://github.com/Theano/libgpuarray.git && \
    cd libgpuarray && \
    mkdir Build && \
    cd Build &&\
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make && \
    make install && \
    cd .. && \
    python setup.py build && \
    python setup.py install && \
    cd ..

# Can't install pycuda without the development version of the nvidia image, which is not passed along by the TensorFlow people
# If we really want this, we can install with `apt-get install python3-pycuda`, but it will add >2 GB to the build

# Set the entrypoint
ENTRYPOINT [ "/bin/bash" ]