FROM ubuntu:18.04

WORKDIR /tmp
COPY sources.list /etc/apt/sources.list
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl xz-utils \
    && curl -L -O --referer https://support.amd.com https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-18.20-606296.tar.xz \
    && tar -Jxvf amdgpu-pro-18.20-606296.tar.xz \
    && rm amdgpu-pro-18.20-606296.tar.xz \
    && chmod +x ./amdgpu-pro-18.20-606296/amdgpu-pro-install \
    && ./amdgpu-pro-18.20-606296/amdgpu-pro-install -y  \
    && rm -r amdgpu-pro-18.20-606296 \
    && apt-get install -y opencl-amdgpu-pro \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

#COPY ethminer /
COPY run_eth.sh /
ENTRYPOINT ["/run_eth.sh"]
#CMD [""]

