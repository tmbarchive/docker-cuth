FROM cupy
MAINTAINER Tom Breuel <tmbdev@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

WORKDIR /root
RUN git clone https://github.com/torch/distro.git /root/torch --recursive
RUN cd /root/torch && bash install-deps && ./install.sh -b
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

RUN apt-get install -y libssl-dev
RUN git clone https://github.com/facebook/iTorch.git && cd iTorch && luarocks make

RUN pip install lutorpy
RUN luarocks install image
RUN luarocks install qtlua
RUN luarocks install camera
RUN luarocks install inline-c
# RUN luarocks install neuflow

RUN git clone https://github.com/deepmind/torch-hdf5.git && cd torch-hdf5 && luarocks make
RUN luarocks install lzmq
