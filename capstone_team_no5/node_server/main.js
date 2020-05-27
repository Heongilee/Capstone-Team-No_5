const mymodule = require("./mynodemailer");
var https = require('https');
var fs = require('fs');
var url = require('url');

https.createServer(function (request, response){
   // URL 뒤에 있는 디렉토리/파일이름 파싱
   var pathname = url.parse(request.url).pathname;

   console.log("Request for" + pathname + "received.");

   // 파일 이름이 비어 있다면, index.html로 설정.
   if(pathname == "/") pathname = "/index.html";

   fs.readFile(pathname.substr(1), function(err, data){
      if(err){
         console.log(err);

         // 페이지를 찾을 수 없음.
         // HTTP Status: 404 : NOT FOUND

         //Content Type: text/plain
         response.writeHead(404, {'Content-Type': 'text/html'});
      } else{
         // 페이지를 찾음
         // HTTP Status: 200: OK

         //Content Type: text/plain
         response.writeHead(200, {'Content-Type': 'text/html'});

         response.writeHead(data.toString());
      }
      response.end();
   });
}).listen(8081);

console.log('Server running at http://127.0.0.1:8081/');

// // (코드가 바뀔 때 마다 refresh ↓)
// // C:\..\node_server>nodemon main.js
// async function main(){
//    const app = await mymodule("56789", "lanelevine@sju.ac.kr") ;
// }