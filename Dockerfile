FROM python:3.9.1-alpine as scratch

WORKDIR /opt/svc

COPY src/ ./
COPY requirements.txt ./

RUN pip install -r requirements.txt

FROM scratch as test
COPY pytest.ini ./
COPY test-requirements.txt ./

RUN pip install -r test-requirements.txt

CMD ["pytest", "tests/"]

FROM scratch

CMD ["python", "app.py"]
