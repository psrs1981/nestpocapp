# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/nestpocapp

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Copy the .env and .env.development files
# COPY .env .env.development ./

# Creates a "dist" folder with the production build
RUN npm run build

RUN if [ "$ARG_NAME" = "dev" ]; then echo dev; \
    elif [ "$ARG_NAME" = "uat" ]; then echo uat; \
    else echo prod; fi
RUN npm run test

# Expose the port on which the app will run
EXPOSE 3009

# Start the server using the production build
CMD ["npm", "run", "start:prod"]
