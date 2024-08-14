FROM node:18 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application code to the container
COPY . .

# Build the React app for production
RUN npm run build

# Use Nginx as the production server
FROM nginx:alpine

# Copy the built React app to Nginx's web server directory
COPY --from=build /app/public /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]


# http://localhost:3000/?data=ZmlsZXBhdGg9aHR0cHM6Ly93d3cuYWZyaWNhdS5lZHUvaW1hZ2VzL2RlZmF1bHQvc2FtcGxlLnBkZiZpZD0x#close