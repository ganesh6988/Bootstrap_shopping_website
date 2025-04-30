# Use Nginx as base image
FROM nginx:alpine

# Copy all website files to Nginx web root
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
