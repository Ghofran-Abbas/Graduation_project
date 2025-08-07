importScripts('https://www.gstatic.com/firebasejs/9.22.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.22.1/firebase-messaging-compat.js');

// نفس إعداداتك هنا:
firebase.initializeApp({
    apiKey: "AIzaSyBrBrrP8RmHbdj0CA9aXhonShhB10k0ryo",
    authDomain: "graduationproject-3d3b0.firebaseapp.com",
    projectId: "graduationproject-3d3b0",
    storageBucket: "graduationproject-3d3b0.firebasestorage.app",
    messagingSenderId: "425903761784",
    appId: "1:425903761784:web:29ce80432a0313e58f808d"
});

const messaging = firebase.messaging();

// هذا للتعامل مع الرسائل عند كون التطبيق في الخلفية
messaging.onBackgroundMessage(function(payload) {
  const { title, body, icon } = payload.notification;
  self.registration.showNotification(title, {
    body,
    icon
  });
});
