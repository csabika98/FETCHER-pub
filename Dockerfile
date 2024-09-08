FROM python:slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    apt-get install -y --no-install-recommends x11vnc xvfb git procps && \
    pip install numpy && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN x11vnc -storepasswd FETCHERALPHA /etc/x11vnc.pass
EXPOSE 8080
EXPOSE 5900
EXPOSE 6080
COPY index.html /opt/noVNC/index.html
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python", "FETCHERV2.py"]

