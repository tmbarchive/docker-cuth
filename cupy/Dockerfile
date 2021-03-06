FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER Tom Breuel <tmbdev@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update -y
RUN apt-get dist-upgrade -y
RUN apt-get -y install sudo lsb-release

RUN apt-get -y install build-essential git software-properties-common
RUN apt-get -y install libhdf5-dev 
RUN apt-get -y install python python2.7-dev libpython2.7-dev
RUN apt-get -y install python-pip
RUN pip install --upgrade pip

RUN pip install numpy
RUN pip install scipy
RUN pip install matplotlib
RUN pip install h5py
RUN pip install pyzmq
RUN pip install msgpack-python
RUN pip install pandas
RUN pip install jupyter

RUN pip install scikit-learn
RUN pip install scikit-image
RUN pip install sklearn-extras

RUN pip install pycuda
RUN pip install scikit-cuda
RUN pip install pyfft

# RUN pip install reikna
# RUN pip install cupy
# RUN pip install chainer

COPY jupyter_notebook_config.py /root/.jupyter/
COPY jupyter.sh /usr/bin/jupyter.sh
RUN chmod 755 /usr/bin/jupyter.sh
EXPOSE 8888
WORKDIR "/notebooks"
CMD ["/usr/bin/jupyter.sh"]
