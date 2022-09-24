FROM python:3.9

ARG DOCKER_IMAGE_VERSION=0.1

LABEL \
      org.label-schema.name="argonAPI" \
      org.label-schema.description="Docker container for argonAPI" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/noatgnu/argonAPI" \
      org.label-schema.schema-version="1.0"

EXPOSE 80

RUN mkdir /app
RUN mkdir /app/src
RUN mkdir /app/data

WORKDIR /app/src

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install git -y

RUN git clone https://github.com/noatgnu/argonAPI.git
WORKDIR /app/src/argonAPI
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]