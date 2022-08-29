FROM python:3.9-slim
RUN apt update && apt install -y curl gcc pkg-config make && apt clean && rm -rf /var/lib/apt/lists/*
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"
WORKDIR /app
COPY . .
RUN poetry config virtualenvs.create false
RUN apt update && apt install -y gcc pkg-config make && poetry install --no-dev --no-root && apt purge -y gcc pkg-config make && apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*
RUN poetry run python build.py
EXPOSE 5000
CMD ["poetry", "run", "lnbits", "--port", "5000", "--host", "0.0.0.0"]
