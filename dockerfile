
FROM php:7.2-fpm

# Copiar composer.lock y composer.json
COPY composer.lock composer.json /var/www/

# Configura el directorio raiz
WORKDIR /var/www

# Instalamos dependencias
RUN apt-get update && apt-get install -y \
    build-essential \
    locales \
    zip \
    vim \
    unzip \
    git \
    curl
# Instalar composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar el directorio existente a /var/www
COPY . /var/www

# copiar los permisos del directorio de la aplicación
COPY --chown=www:www . /var/www

# exponer el puerto 9000 e iniciar php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
