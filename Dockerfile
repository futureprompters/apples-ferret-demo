FROM python:3.10-bookworm

# Install git & git-lfs
RUN apt update && apt -y install git curl

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt install git-lfs \
    && git lfs install


RUN useradd -m -u 1000 user

# Switch to the "user" user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app setting the owner to the user
COPY --chown=user . $HOME/app

# Install Poetry
RUN pip install --no-cache-dir --upgrade pip \
    && pip install poetry

# Install dependencies defined in pyproject.toml
RUN poetry config virtualenvs.create false \
    && poetry install --only main

# Run the ferret
EXPOSE 7860

CMD ["poetry", "run", "python", "src/ferret/app.py"]
