FROM python:3.10-bookworm

# HuggingFace Access Token for downloading the models
ARG HF_TOKEN

# Switch to non-root user
RUN useradd -m -u 1000 non-root
USER non-root

ENV PATH=/home/non-root/.local/bin:$PATH

# Set the working directory to the non-root's home directory
WORKDIR /home/non-root/app


# Copy the current directory contents into the container at /home/non-root/app setting the owner to the non-root
COPY --chown=non-root . /home/non-root/app

# Install Poetry
RUN pip install --no-cache-dir --upgrade --user pip poetry

# Install dependencies defined in pyproject.toml
RUN poetry install --only main

# Expose secret HF_TOKEN stored in HF Space and
# download the model stored in HuggingFace Hub
RUN --mount=type=secret,id=HF_TOKEN,mode=0444,required=true \
    && poetry run huggingface-cli download FuturePrompters/apples-ferret \
    --token $(cat /run/secrets/HF_TOKEN) \
    --local-dir /home/non-root/app/model

# Run the ferret
EXPOSE 7860

CMD ["poetry", "run", "python", "/home/non-root/app/src/ferret/app.py"]
