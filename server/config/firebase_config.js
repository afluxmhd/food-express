const admin = require('firebase-admin');

function initializeFirebase(){
    const serviceAccount = require('/etc/secrets/firebase_service_acc_file'); //Private key file path of Firebase project

    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    });
    console.log('Firebase initialized successfully');
}



module.exports = initializeFirebase;