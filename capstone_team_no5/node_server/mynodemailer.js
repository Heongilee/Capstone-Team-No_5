const mynodemailer = (myAuthenticationCode, recepient) => {
  var nodemailer = require("nodemailer");
  var smtpTransport = require("nodemailer-smtp-transport");
  // -------------------- google Account info ---------------------------------------
  var adminEmail = "putitaway2020@gmail.com";
  var adminPassword = "putitaway1234!";
  // --------------------------------------------------------------------------------
  var transporter = nodemailer.createTransport(
    smtpTransport({
      service: "gmail",
      host: "smtp.gmail.com",
      port: 25,
      secure: false,
      auth: {
        user: adminEmail,
        pass: adminPassword,
      },
      tls: {
        rejectUnauthorized: false,
      },
    })
  );
  var mailOptions = {
    from: adminEmail,
    to: recepient,
    subject: "\'치워\'어플의 인증코드를 입력 바랍니다. => "+ myAuthenticationCode,
    text:
      "'치워'어플의 이메일 인증 코드는 다음과 같습니다.\n\t\t인증코드 : " +
      myAuthenticationCode +
      "\n\n\n저희 어플을 이용해주셔서 감사합니다.",
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log("Email sent: " + info.response);
    }
    console.log();
  });
};

// 모듈화
module.exports = mynodemailer;