import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/login_seller_account.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebase(File imageFile) async {
    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Get a reference to the Firebase Storage bucket
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');

    // Create a task to upload the image file
    final UploadTask uploadTask = storageRef.putFile(imageFile);

    // Wait for the upload task to complete and return the download URL
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //Customer function
  signUpCustomer(
      String fullName, String email, String password, File? imageFile) async {
    loading();
    //SingnUP method
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //Upload image url into Firebase Storage.
    Future<String> downloadUrl = uploadImageToFirebase(imageFile!);
    // Future<String> is need to be set in string data type.
    String imageDownloadUrl = await downloadUrl;
    //Create cloud database with a collection name user and set fields fullName, email, imageFile who are signUP.
    await firestore.collection('customers').doc(userCredential.user!.uid).set({
      'cid': userCredential.user!.uid,
      'fullName': fullName,
      'email': email,
      'imageFile': imageDownloadUrl,
      'phoneNumber': '',
      'address': ''
    });
    dismissLoading();
  }

  //Customer function
  loginCustomer(String email, String password) async {
    loading();
    UserCredential loginResponse =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    // ignore: unnecessary_null_comparison
    if (loginResponse != null) {
      await saveToSharedPreferences(
          sharedPrefCustomerUid, loginResponse.user!.uid);
      await saveToSharedPreferences(sharedPrefSellerUid, null);
    }
    dismissLoading();
  }

  //Seller function
  signUpSeller(
      String fullName, String email, String password, File? imageFile) async {
    loading();
    //SingnUP method
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //Upload image url into Firebase Storage.
    Future<String> downloadUrl = uploadImageToFirebase(imageFile!);
    // Future<String> is need to be set in string data type.
    String imageDownloadUrl = await downloadUrl;
    //Create cloud database with a collection name user and set fields fullName, email, imageFile who are signUP.
    await firestore.collection('sellers').doc(userCredential.user!.uid).set({
      'sid': userCredential.user!.uid,
      'fullName': fullName,
      'email': email,
      'imageFile': imageDownloadUrl,
      'phoneNumber': '',
      'address': ''
    });
    dismissLoading();
  }

  //Seller function
  loginSeller(String email, String password) async {
    loading();
    UserCredential loginResponse =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    // ignore: unnecessary_null_comparison
    if (loginResponse != null) {
      await saveToSharedPreferences(
          sharedPrefSellerUid, loginResponse.user!.uid);
      await saveToSharedPreferences(sharedPrefCustomerUid, null);
    }
    dismissLoading();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> userCustomerInfo() async {
    loading();

    dynamic jwt = await readFromSharedPreferences(sharedPrefCustomerUid);
    String userJwt = jwt;
    var collectionReference = FirebaseFirestore.instance.collection(customers);
    var profileData = collectionReference.doc(userJwt).get();
    return profileData;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> userSellerInfo() async {
    loading();
    dynamic jwt = await readFromSharedPreferences(sharedPrefSellerUid);
    String userJwt = jwt;
    var collectionReference = FirebaseFirestore.instance.collection(sellers);
    var profileData = collectionReference.doc(userJwt).get();
    return profileData;
  }

  Future<void> logoutCustomer(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    loading();
    await auth.signOut();
    await saveToSharedPreferences(sharedPrefCustomerUid, null);
    navigationPush(context, screenWidget: CustomerSignUpScreen());
    dismissLoading();
  }

  Future<void> logoutSeller(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    loading();
    await auth.signOut();
    await saveToSharedPreferences(sharedPrefSellerUid, null);
    navigationPush(context, screenWidget: SellerLoginScreen());
    dismissLoading();
  }
}
