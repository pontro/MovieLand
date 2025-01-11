# Etapa 1: Construcción de la aplicación (build)
FROM node:20-alpine AS build

# Definir el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY package.json package-lock.json ./

# Instalar dependencias del proyecto
RUN npm install

# Copiar el código fuente de la aplicación al contenedor
COPY . .

# Construir el proyecto (con Vite)
RUN npm run build

# Etapa 2: Servir la aplicación (producción)
FROM nginx:alpine

# Copiar los archivos construidos desde la etapa anterior
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer el puerto que utilizará el contenedor
EXPOSE 80

# Iniciar Nginx para servir la aplicación
CMD ["nginx", "-g", "daemon off;"]
