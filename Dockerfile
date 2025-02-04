# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/nestpocapp

ARG ENV=DEV

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

RUN if [ "$ENV" = "DEV" ]; then echo dev; \
    elif [ "$ENV" = "uat" ]; then echo uat; \
    else echo prod; fi
RUN npm run test

# Expose the port on which the app will run
EXPOSE 3009

# Start the server using the production build
CMD ["npm", "run", "start:prod"]
