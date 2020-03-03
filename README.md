# fnallpc-docker
This repository contains the Docker projects for the LHC Physics Center at Fermilab.

<!-- MarkdownTOC levels="2,3" autolink="true" -->

- [Build Instructions](#build-instructions)
- [Use Instructions](#use-instructions)
- [Source Containers](#source-containers)
- [Conda Packages Included](#conda-packages-included)

<!-- /MarkdownTOC -->

## Build Instructions

## Use Instructions

## Source Containers

## Conda Packages Included
| Environment Name     | Python 3.7 Container      | Python 2.7 Container      |
| :------------------- | :------------------------ | :------------------------ |
| Notes                | --                        | --                        |
| arrow-cpp            | 0.15.1                    | 0.11.1                    |
| awkward              | 0.12.20                   | 0.12.20                   |
| bazel                | 0.26.1                    | 0.26.1                    |
| blaze                | 0.11.3                    | 0.11.3                    |
| bokeh                | 1.4.0                     | 1.4.0                     |
| boost-cpp            | 1.71.0                    | --                        |
| cuda                 | 9.0.176 \*                | 9.0.176 \*                |
| cudatoolkit          | 10.1.243                  | 10.1.243                  |
| cudnn                | 7.6.5                     | 7.6.5                     |
| dask                 | 2.10.1                    | 1.2.2                     |
| EnergyFlow           | 1.0.2                     | 1.0.2                     |
| graphviz             | 2.40.1                    | 2.40.1                    |
| h5py                 | 2.10.0                    | 2.9.0                     |
| intel-openmp         | 2020.0                    | 2020.0                    |
| ipython              | 7.12.0                    | 5.8.0                     |
| jupyter_client       | 5.3.4                     | 5.3.4                     |
| jupyter_core         | 4.6.1                     | 4.6.1                     |
| keras-applications   | 1.0.8                     | 1.0.8                     |
| keras-base           | 2.2.4                     | 2.2.4                     |
| keras-gpu            | 2.2.4                     | 2.2.4                     |
| keras-preprocessing  | 1.1.0                     | 1.1.0                     |
| libboost             | 1.71.0                    | 1.67.0                    |
| matplotlib           | 3.1.3                     | 2.2.3                     |
| mkl                  | 2020.0                    | 2020.0                    |
| mplhep               | 0.0.35                    | 0.0.35                    |
| nb_conda             | 2.2.1                     | 2.2.1                     |
| numba                | 0.48.0                    | 0.47.0                    |
| numpy                | 1.18.1                    | 1.16.6                    |
| pandas               | 1.0.0                     | 0.24.2                    |
| pip                  | 20.0.2                    | 19.3.1                    |
| pyarrow              | 0.15.1                    | 0.11.1                    |
| pycuda               | 2019.1.2                  | 2019.1.2                  |
| pydot                | 1.4.1                     | 1.4.1                     |
| pygpu                | 0.7.6                     | 0.7.6                     |
| python               | 3.7.6                     | 2.7.17                    |
| PyTorch              | 1.3.1                     | 1.3.1                     |
| root                 | --                        | --                        |
| rootpy               | --                        | --                        |
| scikit-image         | 0.16.2                    | 0.14.2                    |
| scikit-learn         | 0.22.1                    | 0.20.3                    |
| scipy                | 1.4.1                     | 1.2.1                     |
| tensorboard          | 1.14.0                    | 1.14.0                    |
| tensorflow           | 1.14.0                    | 1.14.0                    |
| tensorflow-base      | 1.14.0                    | 1.14.0                    |
| tensorflow-estimator | 1.14.0                    | 1.14.0                    |
| tensorflow-gpu       | 1.14.0                    | 1.14.0                    |
| Theano               | 1.0.4                     | 1.0.4                     |
| torchvision          | 0.4.2                     | 0.4.2                     |
| uproot               | 3.11.2                    | 3.11.2                    |
| uproot-methods       | 0.7.3                     | 0.7.3                     |
| wheel                | 0.34.2                    | 0.33.6                    |
| yaml                 | 0.1.7                     | 0.1.7                     |

## To Run
docker run --rm -it -P --device /dev/fuse --net=host -e DISPLAY=host.docker.internal:0 -e MY_UID=501 -e MY_GID=20 tensorflow/tensorflow:latest-gpu-py3-jupyter
docker run --rm -it -P --device /dev/fuse --net=host -e DISPLAY=host.docker.internal:0 -e MY_UID=$(id -u) -e MY_GID=$(id -g) tensorflow/tensorflow:latest-gpu-py3