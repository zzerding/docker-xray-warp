FROM ubuntu:22.10
#warp-svc use systemd ,docker run systemd is Insecure 

# install supervisor and Docker Engine 
RUN --mount=type=cache,target=/var/cache/apt \
    apt update \
    && apt install -y curl gpg supervisor \
    && curl https://pkg.cloudflareclient.com/pubkey.gpg |  gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ jammy main" |  tee /etc/apt/sources.list.d/cloudflare-client.list \
    && apt update \
    && apt install cloudflare-warp -y \
    && apt-get autoremove -y \
    &&  apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/warp.conf
# init.sh is a warp-cli init file
COPY init.sh /init.sh
CMD ["/usr/bin/supervisord"]
