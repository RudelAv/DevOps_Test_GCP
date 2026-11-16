FROM php:8.3-fpm-alpine

# Install dependencies 
RUN apk add --no-cache nginx supervisor

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Create application directory
WORKDIR /var/www/html

# Copy application files
COPY --chown=www-data:www-data public/ /var/www/html/public/

# Copy Nginx configuration
COPY nginx/default.conf /etc/nginx/http.d/default.conf

COPY supervisord.conf /etc/supervisord.conf

# Expose ports
EXPOSE 8080

# Start Nginx and PHP-FPM
CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]