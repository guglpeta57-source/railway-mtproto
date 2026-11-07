FROM python:3.11-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/alexbers/mtprotoproxy.git .

# uvloop нужен для асинхронной производительности под высокими нагрузками
RUN pip install cryptography uvloop

# Скрипт запуска подхватывает внутренний PORT от Railway
RUN echo '#!/bin/sh\npython3 mtprotoproxy.py -p $PORT -s $SECRET' > run.sh
RUN chmod +x run.sh

CMD ["./run.sh"]
