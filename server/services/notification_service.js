const admin = require('firebase-admin');

function sendPushNotification(fcmToken, title, message){
    const notificationMessage={
        notification : {
            title: title,
            body: message
        },
        token: fcmToken
    }

    return admin.messaging().send(notificationMessage)
}

module.exports = {
    sendPushNotification
};