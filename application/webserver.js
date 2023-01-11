const NODE_ENV	= process.env.NODE_ENV || 'LOCAL';
const PORT 	= process.env.PORT || 4800;
const NAME	= process.env.NAME || 'Name env var Missing';

var http = require('http');

var server = http.createServer(function (request, response) {
    if (request.url == '/') {
        response.writeHead(200, { 'Content-Type': 'text/html' }); 
        response.write(`<html><body><p>Hello, my name is: ${NAME}<br>NODE_ENV: ${NODE_ENV}</p></body></html>`);
        response.end();
    }
    else
        response.end('Invalid Request!');
});

server.listen(PORT, () => {
  console.log(`Listening at port... ${PORT}`);
});
