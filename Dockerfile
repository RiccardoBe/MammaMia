# Use an official Python runtime as a parent image
FROM python:3.10-slim-bookworm
# Set the working directory in the container to /app
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc pkg-config libffi-dev \
 && rm -rf /var/lib/apt/lists/*

 RUN pip install --upgrade pip setuptools wheel

# Copy the current directory contents into the container at /app 
ADD . /app
# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get purge -y build-essential gcc pkg-config libffi-dev && \
    apt-get autoremove -y && apt-get clean
    
#EXPOSE the port, for now default is 8080 cause it's the only one really allowed by HuggingFace
EXPOSE 8080

# Run run.py when the container launches
CMD ["python", "run.py"]