const functions = require("firebase-functions");

exports.invite = functions.https
.onRequest(async (req, res) => {
    // this funtion url - https://us-central1-<project-id>.cloudfunctions.net/date
    //https://us-central1-viewyourstories-4bf4d.cloudfunctions.net/date

     const dataQuery = req.query;

     const shareId = dataQuery.shareId;

     const adUrl = dataQuery.adUrl;

     const adId = dataQuery.adId;

     const promoterId = dataQuery.promoterId;

    const promotedAdRef =  admin.firestore().collection('promotedAds').doc(promoterId).collection('ads').doc(adId);

    await promotedAdRef.update({'clicks': admin.firestore.FieldValue.arrayUnion(shareId)}) 

    res.redirect(adUrl);

    });