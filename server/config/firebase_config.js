const admin = require('firebase-admin');

function initializeFirebase(){
    const serviceAccount = require('../food-express07-firebase-adminsdk-mzq1u-8309f33171.json'); //Private key file path of Firebase project

    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    });
    console.log('Firebase initialized successfully');
}



module.exports = initializeFirebase;