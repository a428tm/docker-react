# this is going to be called builder by doing this
FROM node:alpine as builder 

WORKDIR '/app'
COPY package.json .
RUN npm install
# we don't need volumes since it was for dev purpose
COPY . .

# by doing this, it will go into build folder
RUN npm run build
# /app/build - all files will go in here in the container


# Once above commands run (it goes by FROM block)
FROM nginx
# we are saying.. we want to copy from builder... 
# from folder /app/build to /usr/share/nginx/html
# this information can be found from hub.docker.com/_/nginx
# this is to host static content
COPY --from=builder /app/build /usr/share/nginx/html

