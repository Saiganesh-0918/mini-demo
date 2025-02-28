FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy files to the container
COPY . /app

# Create virtual environment and install dependencies
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Expose the Flask app port
EXPOSE 5000

# Run the application
CMD ["venv/bin/python", "app.py"]

