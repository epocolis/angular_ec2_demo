# Use an official Node runtime as the build image
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json for installing dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Build the Angular app in production mode
RUN npm run build --prod

# Use an official Nginx runtime as the base image
FROM nginx:alpine

# Copy the compiled app to serve it through Nginx
COPY --from=build /app/dist/your-app-name /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
