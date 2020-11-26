const http = require('http');
const timeout = 150000;

const handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);

  switch (request.url) {
    case "/timeout":
      setTimeout(()=>{
        response.writeHead(200);
        response.end(`Hello World after ${timeout/1000}s!\n`);
      }, timeout);
      break;

    default:
      response.writeHead(200);
      response.end(`Hello World!\n`);
      break;
  }
};
var www = http.createServer(handleRequest);
console.log("Listening on port 8080");
www.listen(8080);
