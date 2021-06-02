ARG PyTorch_Version=1.8.1-cuda11.1-cudnn8
ARG PyTorch_Variants=-runtime
FROM pytorch/pytorch:${PyTorch_Version}${PyTorch_Variants}
MAINTAINER Alexx Perloff "Alexx.Perloff@Colorado.edu"

ARG TORCH_VERSION=1.8.1
ARG CUDA_VERSION=cu111
RUN apt-get update --fix-missing && \
    apt-get install -y wget git nano && \
    apt-get clean && \
    /opt/conda/bin/conda install -y blaze dask graphviz matplotlib numba pandas pydot pygpu pytest scikit-image scikit-learn PyHamcrest && \
    /opt/conda/bin/conda install -y -c conda-forge gpyopt ipywidgets jupyterlab nodejs notebook mlflow opencv py-opencv pytables uproot uproot-methods widgetsnbextension && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    pip install --no-cache-dir energyflow && \
    pip install --no-cache-dir torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH_VERSION}+${CUDA_VERSION}.html && \
    pip install --no-cache-dir torch-geometric && \
    /opt/conda/bin/conda clean -ya && \
    rm -r .empty

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