const http = require('http');
const url = require('url');

const handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);

  parsedUrl = url.parse(request.url, true)

  switch (parsedUrl.pathname) {
    case "/timeout":
      period = parsedUrl.query.period
      timeout = isNaN(period) ? 0 : period * 1000

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
