const mymodule = require("./mynodemailer");
var http = require("http");
var express = require("express");
var app = express();

app.get("/", function(req, res){
  res.writeHead(404);
  res.end('Not Found');
});
app.get("/create-mailer", async function (req, res) {
  console.log('app.get() called');

  await mymodule("56789", "lanelevine@sju.ac.kr") ;

  res.writeHead(200);
  res.end("Emailer Module Done.");
});
app.listen(8080, function () {
  console.log("http://127.0.0.1:8080/ Server Running...");
  console.log("http://127.0.0.1:8080/create-mailer We want to ...");
});

// var fs = require('fs');
// var app = http.createServer(async function(request, response){
//   var url = request.url;
//   //라우트가 아무것도 없이 들어오면 inde
//   // if(request.url == '/'){
//   //   url = '/index.html';
//   // }
//   if(request.url == '/create-mailer'){
//     await mymodule("56789", "lanelevine@sju.ac.kr") ;
//     url = '/index.html';
//   }
//   // 이거 뭔지 모르겠으... 걍 써둠;
//   response.writeHead(200);
//   response.end(fs.readFileSync(__dirname + url));
// });
// app.listen(8080, function(){
//   //Test-bench
//   console.log('http://127.0.0.1:8080/ Server Running...');
//   console.log('http://127.0.0.1:8080/create-mailer We want to ...');
// });
