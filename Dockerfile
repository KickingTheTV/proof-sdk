FROM node:20-slim

WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./

RUN npm ci

# Copy source
COPY . .

# Build frontend
RUN npm run build

# Expose API port
EXPOSE 4000

# Default environment
ENV PORT=4000
ENV NODE_ENV=production
ENV COLLAB_EMBEDDED_WS=true

# Start the API server (serves both API and built frontend)
CMD ["npx", "tsx", "server/index.ts"]
