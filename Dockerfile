# Stage 1: Build the app
FROM registry.access.redhat.com/ubi8/nodejs-18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the app
RUN npm run build

# Stage 2: Create a lightweight image to run the app
FROM registry.access.redhat.com/ubi8/nodejs-18 AS production

# Set the working directory
WORKDIR /app

# Copy the built app from the previous stage
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./

# Expose the desired port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]