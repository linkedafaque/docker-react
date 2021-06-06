# Build Phase - Container 1
# Construct 'build ' folder npm run build
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase - Container 2
# Copy build output (stuff we care about in production)
# Run nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Default command for nginx contianer will start nginx for us,
# we dont have to run anything.

# Nothing is being copied, not the alpine, for node_modules,
# only the build folder is being copied to the new nginx image.