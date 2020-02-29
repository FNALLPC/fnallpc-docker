ARG TensorFlow_Version=latest
ARG TensorFlow_Variants=-gpu-py3-jupyter
FROM tensorflow/tensorflow:${TensorFlow_Version}${TensorFlow_Variants}
MAINTAINER Alexx Perloff "Alexx.Perloff@Colorado.edu"

# Merge in the directions to install miniconda
# Taken from https://hub.docker.com/r/continuumio/anaconda/dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

# Once Anaconda is installed, setup the needed software using conda install commands
ADD conda_env.yml conda_env.yml 
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    . /opt/conda/etc/profile.d/conda.sh && \
    conda env update --name base --file conda_env.yml && \
    conda clean -a -y

# Tini project: https://github.com/krallin/tini/
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

# Set the remote user
RUN groupadd cmsuser \
    && useradd -m -s /bin/bash -g cmsuser cmsuser

WORKDIR /home/cmsuser
ADD append_to_bashrc.sh .append_to_bashrc.sh
RUN cat .append_to_bashrc.sh >> .bashrc

# Set the entrypoint
ADD run.sh /run.sh
ENTRYPOINT [ "/usr/bin/tini", "--", "/run.sh" ]