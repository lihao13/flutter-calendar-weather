# Build stage
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .

RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web --release --base-href "/"

# Deploy stage using nginx
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html
COPY --from=build /app/build/web/assets /usr/share/nginx/html/assets

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
