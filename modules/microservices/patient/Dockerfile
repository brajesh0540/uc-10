# Use official Node.js LTS version as base
FROM node:current-alpine3.22

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install app dependencies
RUN npm install --production

# Copy app source code
COPY . .

# Expose port 80 (or whichever port your app listens on)
EXPOSE 80

# Run the app
CMD ["node", "patient-service.js"]
