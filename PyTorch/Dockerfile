ARG PyTorch_Version=1.5-cuda10.1-cudnn7
ARG PyTorch_Variants=-runtime
FROM pytorch/pytorch:${PyTorch_Version}${PyTorch_Variants}
MAINTAINER Alexx Perloff "Alexx.Perloff@Colorado.edu"

RUN apt-get update --fix-missing && \
    apt-get install -y wget git && \
    apt-get clean && \
    /opt/conda/bin/conda install -y blaze dask graphviz matplotlib numba pandas pydot pygpu pytest scikit-image scikit-learn PyHamcrest && \
    /opt/conda/bin/conda install -y -c conda-forge gpyopt mlflow pytables uproot uproot-methods && \
    pip install --no-cache-dir energyflow && \
    /opt/conda/bin/conda clean -ya && \
    rm -r .empty

# Conda pycuda by lukepfister and powerai don't install in python 3.7
# If we want pycuda we should install with 'apt-get install python3-pycuda'
RUN if [[ "${PyTorch_Variants}" == *"devel"* ]]; then apt-get install -y python3-pycuda && apt-get clean; else echo "building without pycuda" ; fi

# Set the entrypoint
ENTRYPOINT [ "/bin/bash" ]