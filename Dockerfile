# as building - from this from command and everything under it is going to referred to as the builder phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# don't need to do the volumes for production
RUN npm run build

# /app/build <--- all the stuff we care about 

# specify start of a second phase
# phases can only have one from statement
FROM nginx
# expose the ports for elasticbeanstalk use
EXPOSE 80
# copy something over from the builder phase
# copying tyhe contents of /app/build to /usr/share/nginx/html - this is from the nginx instructions page
COPY --from=builder /app/build /usr/share/nginx/html