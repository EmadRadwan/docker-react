FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Expose port 80 for AWS Elastic Beanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify CMD because nginx image has a default CMD that starts nginx
