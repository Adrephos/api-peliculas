# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.11-slim-buster

RUN mkdir /api-peliculas
# set up working directory
WORKDIR /api-peliculas
# install dependencies ubunto and curl
RUN apt-get update && apt-get install -y curl
# Copy application
COPY . /api-peliculas
# Install application dependencies
RUN pip3 install -r /api-peliculas/requirements.txt
# define environment variable
ENV FLASK_APP "entrypoint:app"
ENV FLASK_ENV "development"
ENV APP_SETTINGS_MODULE "config.default"
ENV PORT 5000
# Init bd and create schemes
RUN flask db init
RUN flask db migrate
RUN flask db upgrade

EXPOSE ${PORT}

# Init flask with map any ip outside from container
CMD ["flask", "run", "--host", "0.0.0.0"]
