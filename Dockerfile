# Dockerfile (in project root)
FROM nginx:alpine

COPY . /usr/share/nginx/html

# Optional: remove default index
RUN rm -f /usr/share/nginx/html/index.nginx-debian.html || true

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
