FROM php:8.2-apache

# Disable all MPMs first to avoid conflicts
RUN a2dismod mpm_event mpm_worker mpm_prefork

# Enable only one MPM (prefork is safest for PHP)
RUN a2enmod mpm_prefork

# Install common PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy your files
COPY . /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
