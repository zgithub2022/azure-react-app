# Stage 1: Build the React app
FROM node:23-alpine AS build
USER 1000
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
# Leverage caching by installing dependencies first
COPY package.json package-lock.json ./
USER root
RUN npm install --silent
#RUN npm install react-scripts@3.4.1 -g --silent
# Copy the rest of the application code and build for production
COPY . ./
RUN chown -R node:node /app/node_modules && mkdir -p /app/build && chown -R node:node /app/build
USER 1000
RUN npm run build

# Stage 2: Development environment
FROM node:23-alpine AS development
USER 1000
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
# Install dependencies again for development
COPY package.json package-lock.json ./
USER root
RUN npm install --silent
#RUN npm install react-scripts@3.4.1 -g --silent
# Copy the full source code
COPY . ./
RUN chown -R node:node /app/node_modules
USER 1000 
# Expose port for the development server EXPOSE 3000
CMD ["npm", "start"]

# Stage 3: Staging environment
FROM nginx:alpine AS uat
# Copy the production build artifacts from the build stage
COPY --from=build /app/build /usr/share/nginx/html
RUN chown -R nginx:root /etc/nginx && chown nginx:root /var/cache/nginx && chown nginx:root /run
USER nginx
# Expose the default NGINX port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Stage 4: Production environment
FROM nginx:alpine AS production
# Copy the production build artifacts from the build stage
COPY --from=build /app/build /usr/share/nginx/html
RUN chown -R nginx:root /etc/nginx && chown nginx:root /var/cache/nginx && chown nginx:root /run
USER nginx
# Expose the default NGINX port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
