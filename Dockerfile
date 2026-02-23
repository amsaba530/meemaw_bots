FROM rocker/r-ver:4.3.2

RUN install2.r plumber jsonlite httr

WORKDIR /app
COPY . /app

EXPOSE 8000

CMD ["R", "-e", "pr <- plumber::plumb('bot.R'); pr$run(host='0.0.0.0', port=8000)"]
