# FROM node:lts-alpine

# WORKDIR /usr/src/app

# COPY package*.json ./

# RUN npm i

# COPY . .

# EXPOSE 3000

# RUN npm run build

# CMD [ "node", "dist/index.js" ]



# Use the official Node.js Alpine base image
FROM node:lts-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code to the container
COPY . .

# Expose the application port
EXPOSE 3000

# Install the AWS SDK to retrieve secrets from AWS Secrets Manager
RUN npm install aws-sdk

# Build the application (if applicable)
RUN npm run build

# Set environment variables to enable AWS SDK to access Secrets Manager
# The app will fetch the secrets dynamically at runtime
ENV AWS_REGION=ap-south-1
ENV SECRET_NAME=my-docker-secret

# The entry point for the application (it will retrieve secrets from AWS Secrets Manager)
CMD [ "node", "dist/index.js" ]


