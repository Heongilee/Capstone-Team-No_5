import db from './myfirebase/firebaseInit'

var reserveRef = db.collection('reservation');
var allReserves = reserveRef.get().then((snapshot) => {
    // snapshot으로 reservation의 document 들이 들어온다.
    // 그것을 forEach로 순회...
    snapshot.forEach(doc => {
        console.log(doc.id, '=>', doc.data());
    });
}).catch((err) => {
    console.log('Error getting documents', err);
});