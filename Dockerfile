FROM python:3.10-slim

WORKDIR /app

# Системные зависимости для OpenCV
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Python зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем файлы модели и скрипты
COPY model_for_inference.pth .
COPY model_config.json .
COPY inference.py .

# Точка входа
ENTRYPOINT ["python", "inference.py"]