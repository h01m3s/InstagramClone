// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from InstagramClone!");
});

// Listen for Following events and then trigger a push notification
exports.observeFollowing = functions.database.ref('/following/{uid}/{followingId}').onCreate(event => {

    var uid = event.params.uid;
    var followingId = event.params.followingId;
    console.log('User: ' + uid + ' is following: ' + followingId);

    // Trying to figure out fcmToken to send a push message
    return admin.database().ref('/users/' + followingId).once('value', snapshot => {

        var userWeAreFollowing = snapshot.val();
        // console.log('user we are following: ' + userWeAreFollowing);

        return admin.database().ref('/users/' + uid).once('value', snapshot => {
            var userDoingTheFollowing = snapshot.val();
            var message = {
                notification: {
                    title: "You now have a new follower",
                    body: userDoingTheFollowing.username + " is now following you"
                },
              token: userWeAreFollowing.fcmToken
            };

            admin.messaging().send(message)
              .then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
              })
              .catch((error) => {
                console.log('Error sending message:', error);
              });
        });

    });

});

exports.sendPushNotifications = functions.https.onRequest((req, res) => {
    res.send("Attempting to send push notification...")
    console.log("LOGGER --- Trying to send push message...")

    // admin.message().sendToDevice()

    var uid = 'U6KL859nQMWUlSZa8F31BwcOjwY2'

    return admin.database().ref('/users/' + uid).once('value', snapshot => {
        var user = snapshot.val();
        console.log("User username: " + user.username + " fcmToken: " + user.fcmToken);

        // See documentation on defining a message payload.
        var message = {
            notification: {
                title: "Push Notification Title",
                body: "Message Body..."
            },
          data: {
            score: '850',
            time: '2:45'
          },
          token: user.fcmToken
        };

        // Send a message to the device corresponding to the provided
        // registration token.
        admin.messaging().send(message)
          .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
          })
          .catch((error) => {
            console.log('Error sending message:', error);
          });
    });

});
