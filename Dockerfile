# Use official lightweight Nginx image
FROM nginx:alpine

# Remove default static files
RUN rm -rf /usr/share/nginx/html/*

# Copy website files into Nginx web root
COPY . /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
