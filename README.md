# FluffyRabbit

RabbitMQ Docker image with better user management and some additional plugins installed.

## Usage

```
docker run -i \
  -v rabbitdata:/var/lib/rabbitmq \
  -e RABBITMQ_DEFAULT_USER=admin \
  -e RABBITMQ_DEFAULT_PASS=adminpass \
  -e RABBITMQ_APP_USER=appuser \
  -e RABBITMQ_APP_PASS=appuserpass \
```

See [Official RabbitMQ Docker page](https://hub.docker.com/_/rabbitmq/) fore extended usage examples.
