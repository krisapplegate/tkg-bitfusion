FROM nvcr.io/nvidia/rapidsai/rapidsai:0.14-cuda10.2-base-ubuntu18.04

WORKDIR /root/downloads
ENV BASH_ENV ~/.bashrc
SHELL ["/bin/bash", "-c"]

COPY bf1gpu.spec /opt/conda/envs/rapids/share/jupyter/kernels/python3/kernel.json

COPY nvidia-smi /usr/bin/nvidia-smi
COPY bitfusion-client-ubuntu1804_2.0.0-11_amd64.deb .
RUN apt-get update
RUN apt-get install -y ./bitfusion-client-ubuntu1804_2.0.0-11_amd64.deb
RUN bitfusion list_gpus
RUN /opt/conda/envs/rapids/bin/pip3 install tensorflow-gpu keras matplotlib
EXPOSE 8888
WORKDIR /root
ADD https://storage.googleapis.com/tensorflow_docs/docs/site/en/tutorials/keras/classification.ipynb ./
CMD /opt/conda/envs/rapids/bin/jupyter notebook --ip=0.0.0.0 --allow-root --NotebookApp.token=''

