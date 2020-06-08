const myEmailerModule = require("./mynodemailer");
var http = require("http");
var express = require("express");
var app = express();
// 추가 1
const myPushalertModule = require("./mypushalert");

app.get("/", function(req, res){
  res.writeHead(404);
  res.end('Not Found');
});
app.get("/create-mailer", async function (req, res) {
  console.log('app.get() -> /create-mailer called');

  await myEmailerModule("56789", "lanelevine@sju.ac.kr");

  res.writeHead(200);
  res.end("Emailer Module Done.");
});
// 추가 2
app.post("/create-pushalert", async function(req, res){
  console.log('app.get() -> /create-pushalert called');

  await myPushalertModule(req.body.clientToken);

  res.writeHead(201);
  res.end("PushAlert Module Done.");
});
app.listen(8080, function () {
  console.log("http://127.0.0.1:8080/ Server Running...");
  console.log("http://127.0.0.1:8080/create-mailer We want to ...");
});