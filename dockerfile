FROM php:7.4-apache

# Menginstal dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install zip

# Mengaktifkan modul Apache yang diperlukan
RUN a2enmod rewrite

# Mengatur direktori kerja
WORKDIR /var/www/html

# Menyalin file Laravel ke dalam kontainer
COPY . /var/www/html

# Menginstal dependensi PHP menggunakan Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# Menentukan hak akses yang diperlukan
RUN chown -R www-data:www-data /var/www/html