ARG TensorFlow_Version=2.10.0
ARG TensorFlow_Variants=-gpu
FROM tensorflow/tensorflow:${TensorFlow_Version}${TensorFlow_Variants}
MAINTAINER Kevin Pedro "pedrok@fnal.gov"

RUN apt-get update --fix-missing && \
    apt-get install -y curl wget git ca-certificates cmake nano libssl-dev uuid-dev && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Install packages into the default python release
RUN pip install --upgrade requests && \
    pip install --no-cache-dir awkward blaze cython dask gpyopt graphviz hist ipympl jupyterlab keras keras-tuner matplotlib mkl mlflow mlflow-extend \
    	mlflowhelper numba numpy pandas pydot pytest scikit-image scikit-learn tables theano energyflow PyHamcrest uproot vector xrootd && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager

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
    
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/libgpuarray/lib/

# Can't install pycuda without the development version of the nvidia image, which is not passed along by the TensorFlow people
# If we really want this, we can install with `apt-get install python3-pycuda`, but it will add >2 GB to the build

# Set the entrypoint
ENTRYPOINT [ "/bin/bash" ]
