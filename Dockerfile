# Build stage
FROM node:lts-alpine AS build-stage
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM nginx:stable-alpine AS development-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port and start NGINX
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
