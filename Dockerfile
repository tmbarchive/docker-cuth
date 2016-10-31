# FROM nvidia/cuda:7.5
# FROM nvidia/cuda:8.0-ubuntu16.04
FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER Tom Breuel <tmbdev@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get -y install build-essential git software-properties-common
RUN apt-get -y install libhdf5-dev lsb-release
RUN apt-get -y install python python2.7-dev python-pip

RUN lsb_release -a

RUN git clone https://github.com/torch/distro.git /root/torch --recursive 

RUN apt-get -y install sudo
RUN cd /root/torch && bash install-deps && ./install.sh -b

WORKDIR /root

ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH

RUN luarocks install torch
RUN luarocks install nn
RUN luarocks install optim
RUN luarocks install lua-cjson

RUN luarocks install cutorch
RUN luarocks install cunn
RUN luarocks install https://raw.githubusercontent.com/soumith/cudnn.torch/master/cudnn-scm-1.rockspec

RUN luarocks install torchx
RUN luarocks install nnx
RUN luarocks install ffmpeg
RUN luarocks install nninit

RUN luarocks install lua-cmsgpack
RUN apt-get install -y libsqlite3-dev
RUN luarocks install lsqlite3

RUN apt-get -y install python-numpy
RUN git clone https://github.com/opencv/opencv.git
RUN apt-get -y install libpython2.7-dev
ENV CUDA_HOME=/usr/local/cuda
ENV LD_LIBRARY_PATH=$CUDA_HOEM/lib64:$LD_LIBRARY_PATH
RUN apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy
RUN apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
RUN apt-get install -y libblas-dev liblapack-dev
RUN cd opencv && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D CUDA_CUDA_LIBRARY=/usr/local/cuda/targets/x86_64-linux/lib/stubs/libcuda.so \
  -D WITH_CUDA=ON \
  -D ENABLE_FAST_MATH=1 \
  -D CUDA_FAST_MATH=1 \
  -D WITH_CUBLAS=1 \
  -D INSTALL_PYTHON_EXAMPLES=ON \
  -D WITH_TBB=ON \
  -D BUILD_NEW_PYTHON_SUPPORT=ON \
  -D WITH_V4L=ON \
  -D INSTALL_C_EXAMPLES=ON \
  -D BUILD_EXAMPLES=ON \
  -D WITH_QT=ON \
  -D WITH_GTK=ON \
  -D WITH_OPENGL=ON ..
RUN cd /root/opencv/build && make -j 8 && sudo make install

RUN luarocks install https://raw.githubusercontent.com/bshillingford/nnquery/master/rocks/nnquery-scm-1.rockspec
RUN luarocks install https://raw.githubusercontent.com/deepmind/torch-hdf5/master/hdf5-0-0.rockspec
RUN luarocks install cv

# RUN luarocks install thrift
# RUN luarocks install dataset
# RUN luarocks install luaposix
# RUN luarocks install moses
# RUN luarocks install luasocket
# RUN luarocks install parallel
# RUN luarocks install ipc
# RUN luarocks install distlearn
# RUN luarocks install autograd
# RUN luarocks install dpnn
