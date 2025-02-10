# Etapa 1: Construcción
FROM node:16 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto de los archivos de la aplicación
COPY . .

# Construir la aplicación para producción
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiar los archivos de build desde la etapa anterior
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto en el que Nginx servirá la app
EXPOSE 80

# Iniciar Nginx en modo daemon off
CMD ["nginx", "-g", "daemon off;"]
