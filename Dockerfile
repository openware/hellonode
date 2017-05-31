FROM node:8.0

COPY server.js .

EXPOSE 8080
CMD node server.js
