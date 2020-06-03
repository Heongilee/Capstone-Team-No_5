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

  await mymodule("56789", "lanelevine@sju.ac.kr");

  res.writeHead(200);
  res.end("Emailer Module Done.");
});
app.listen(8080, function () {
  console.log("http://127.0.0.1:8080/ Server Running...");
  console.log("http://127.0.0.1:8080/create-mailer We want to ...");
});