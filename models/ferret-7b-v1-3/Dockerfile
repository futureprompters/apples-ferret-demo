FROM python:3.10-bookworm

RUN apt-get -y update && apt-get -y install git

RUN pip install --upgrade pip  # enable PEP 660 support \
    && pip install -e . \
    && pip install pycocotools \
    && pip install protobuf==3.20.0 \
    && pip install ninja \
    && pip install flash-attn --no-build-isolation

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get install git-lfs \
    && git lfs install

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu \
    && pip install transformers

RUN pip install sentencepiece \
    && pip install accelerate \
    && pip install awscli