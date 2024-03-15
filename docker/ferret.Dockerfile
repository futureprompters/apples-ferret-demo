FROM python:3.10-bookworm

# Install git & git-lfs
RUN apt update && apt -y install git curl

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt install git-lfs \
    && git lfs install

# Create a non-root user
RUN mkdir -p /app
WORKDIR /app

# RUN useradd -m -u 1000 user
# USER user
# ENV HOME=/home/user \
#     PATH=/home/user/.local/bin:$PATH
# WORKDIR $HOME/app

# Install Poetry
RUN pip install --no-cache-dir --upgrade pip \
    && pip install poetry

# Copy your pyproject.toml (and possibly poetry.lock) and application code
# COPY --chown=user ../pyproject.toml ../poetry.lock* $HOME/app/
# COPY --chown=user ../src/ferret $HOME/app
COPY ../pyproject.toml ../poetry.lock* /app/
COPY ../src/ferret /app

# Install dependencies defined in pyproject.toml
RUN poetry config virtualenvs.create false \
    && poetry install --only main

# Run the ferret
EXPOSE 7860
CMD ["poetry", "run", "python", "app.py"]
