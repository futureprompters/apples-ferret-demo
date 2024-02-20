FROM python:3.10-bookworm

RUN apt-get -y update && apt-get -y install git


RUN pip install --upgrade pip  # enable PEP 660 support \
    && pip install torch torchvision torchaudio \
    && pip install -e . \
    && pip install pycocotools \
    && pip install protobuf==3.20.0 \
    && pip install ninja \
    && pip install flash-attn --no-build-isolation

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get install git-lfs \
    && git lfs install


RUN pip install einops fastapi gradio==3.26 markdown2[all] numpy \
    requests sentencepiece tokenizers>=0.12.1 \
    torch torchvision uvicorn wandb \
    shortuuid httpx==0.24.0 \
    deepspeed==0.9.5 \
    peft==0.4.0 \
    accelerate==0.21.0 \
    bitsandbytes==0.41.0 \
    scikit-learn==1.2.2 \
    sentencepiece==0.1.99 \
    einops==0.6.1 einops-exts==0.0.4 timm==0.6.13 openai \
    gradio_client==0.1.2


RUN useradd -m -u 1000 user

# Switch to the "user" user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME/app

# Try and run pip command after setting the user with `USER user` to avoid permission issues with Python
RUN pip install --no-cache-dir --upgrade pip

# Copy the current directory contents into the container at $HOME/app setting the owner to the user
COPY --chown=user . $HOME/app

EXPOSE 7860

CMD ["python", "app.py"]

