#Phase 1:Build phase
#Specify a base image
FROM node:alpine as builder

#Specify a working directory. Everything will be executed in the container in /app
WORKDIR '/app'

#Copy the dependencies(package.json) file in the current directory(=working direction=/app)
COPY package.json .

#Install dependencies needed to execute npm run build
RUN npm install

#Copy remaining files in the current directory
COPY . .

#Default command - build the React app
RUN npm run build

#build folder (/app/build) has been created in the current working directory 

#Phase 2: Run phase
#Use nginx
FROM nginx

#Copy over the result of npm run build (or resulted files from the build phase)
#Copy them to the Nginx directory, just as static files:
COPY --from=builder /app/build /usr/share/nginx/html
