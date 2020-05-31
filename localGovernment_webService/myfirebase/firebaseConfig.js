// firebaseConfig.js
// 인증에 필요한 내용을 다루는 코드와 초기화를 진행하는 코드를 분리해서 사용할 것임.

var firebaseConfig = {
  apiKey: "AIzaSyDfLG-WSkckQnW0m95_4Jz2lYH5mAlzIzo",
  authDomain: "capstone-no5.firebaseapp.com",
  databaseURL: "https://capstone-no5.firebaseio.com",
  projectId: "capstone-no5",
  storageBucket: "capstone-no5.appspot.com",
  messagingSenderId: "80279008633",
  appId: "1:80279008633:web:9f59fbcca33ef8a8cdaba8",
  measurementId: "G-EQ9RSJSGE6"
};

module.exports = firebase.initializeApp(firebaseConfig);