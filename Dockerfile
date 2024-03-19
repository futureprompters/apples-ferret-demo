FROM python:3.10-bookworm

# Install git & git-lfs
RUN apt update && apt -y install git curl

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt install git-lfs \
    && git lfs install

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

# Run the ferret
EXPOSE 7860

CMD ["poetry", "run", "python", "/home/non-root/app/src/ferret/app.py"]
