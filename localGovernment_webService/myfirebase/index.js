const cors = require('cors')({
    origin : true
});

exports.myFirebase = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
        // 아니 이건 아니지;;
    });
});