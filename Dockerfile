FROM node:20-slim

WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./
COPY packages/*/package*.json packages/
COPY apps/*/package*.json apps/

RUN npm ci --production=false

# Copy source
COPY . .

# Build frontend
RUN npm run build

# Expose API + editor ports
EXPOSE 4000

# Default environment
ENV PORT=4000
ENV NODE_ENV=production
ENV COLLAB_EMBEDDED_WS=true

# Start the API server (serves both API and built frontend)
CMD ["npx", "tsx", "server/index.ts"]
