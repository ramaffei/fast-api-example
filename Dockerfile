FROM python:3.11-slim
ENV PYTHONUNBUFFERED=1

WORKDIR /workdir

# Copy requirements.txt first for better cache on later pushes and install dependencies
COPY requirements.txt /workdir/requirements.txt
RUN pip3 install -r /workdir/requirements.txt
COPY requirements_lint.txt /workdir/requirements_lint.txt
RUN pip3 install -r /workdir/requirements_lint.txt
COPY app/requirements.txt /workdir/app/requirements.txt
RUN pip3 install -r /workdir/app/requirements.txt
COPY tests/requirements.txt /workdir/tests/requirements.txt
RUN pip3 install -r /workdir/tests/requirements.txt

# Copy the rest of the code
COPY . /workdir/

EXPOSE 8000

# CMD ["uvicorn", "--app-dir", "/workdir/app","main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
