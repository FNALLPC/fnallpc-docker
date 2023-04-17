ARG PyTorch_Version=2.0.0-cuda11.7-cudnn8
ARG PyTorch_Variants=-runtime
FROM pytorch/pytorch:${PyTorch_Version}${PyTorch_Variants}
MAINTAINER Kevin Pedro "pedrok@fnal.gov"

ARG TORCH_VERSION=2.0.0
ARG CUDA_VERSION=cu117

RUN apt-get update --fix-missing && \
    apt-get install -y wget git less nano g++ libssl-dev uuid-dev cmake imagemagick && \
    apt-get clean

# Unable to install libopencv, opencv, or py-opencv using either conda or mamba
#  nor from either the anaconda or the conda-forge channels
RUN echo "\n\nInstalling mamba ..." && \
    conda install mamba -n base -c conda-forge && \
    conda install libarchive==3.5.2 -n base -c conda-forge && \
    echo "\n\nInstalling packages from conda-forge using mamba ..." && \
    mamba install -y -c pytorch -c conda-forge torchvision=0.10.0 'awkward<2' cudatoolkit=11.1 dask distributed gpyopt hist ipympl ipywidgets jax jupyterlab \
      matplotlib mlflow nodejs notebook numba pandas pydot pygpu PyHamcrest pytables pytest \
      scikit-image scikit-learn tensorboardx uproot widgetsnbextension vector xrootd && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    echo "\n\nCleaning the conda cache ..." && \
    /opt/conda/bin/conda clean -ya

# Graphviz moved to pip install because the conda installation is unbearably slow
#  and mamba can't install the needed dependencies correctly
RUN echo "\n\nInstalling packages from pip ..." && \
    pip install --no-cache-dir energyflow graphviz && \
    pip install --no-cache-dir torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-geometric

# Install the LorentzGroupNetwork package
# The source code is on GitHub and is installable with pip, but it is not hosted on PyPi.org
# GitHub: https://github.com/fizisist/LorentzGroupNetwork
RUN cd /opt/ && \
    git clone https://github.com/fizisist/LorentzGroupNetwork.git && \
    cd LorentzGroupNetwork/ && \
    pip install --no-cache-dir . && \
    cd /workspace

# Conda pycuda by lukepfister and powerai don't install in python 3.7
# If we want pycuda we should install with 'apt-get install python3-pycuda'
ARG PyTorch_Variants=-runtime
RUN if [[ "${PyTorch_Variants}" == *"devel"* ]]; then apt-get install -y python3-pycuda && apt-get clean; else echo "building without pycuda" ; fi

# Set the entrypoint
ENTRYPOINT [ "/bin/bash" ]
