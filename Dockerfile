FROM alpine:latest
RUN apk add --no-cache curl unzip ca-certificates
WORKDIR /app
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.10.31/Xray-linux-64.zip && unzip xray.zip xray && rm xray.zip && chmod +x xray
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
EXPOSE 8080
CMD ["/app/entrypoint.sh"]
