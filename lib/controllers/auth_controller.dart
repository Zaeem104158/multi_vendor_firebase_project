import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/login_seller_account.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  final TextEditingController fullNameTextEditingController =
      TextEditingController();
  File? image;
  final FocusNode focusNode = FocusNode();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  void getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    notifyListeners();
  }

  Future<String> uploadUserImageToFirebase(File imageFile, directory) async {
    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Get a reference to the Firebase Storage bucket
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('$directory/$fileName');

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
    Future<String> downloadUrl =
        uploadUserImageToFirebase(imageFile!, customerProfileImageDirectory);
    // Future<String> is need to be set in string data type.
    String imageDownloadUrl = await downloadUrl;
    //Create cloud database with a collection name user and set fields fullName, email, imageFile who are signUP.
    await firestore
        .collection(customersDirectory)
        .doc(userCredential.user!.uid)
        .set({
      customersCollectionFieldCid: userCredential.user!.uid,
      customersCollectionFieldFullName: fullName,
      customersCollectionFieldEmail: email,
      customersCollectionFieldImageFile: imageDownloadUrl,
      customersCollectionFieldPhoneNumber: '',
      customersCollectionFieldAddress: ''
    });
    dismissLoading();
  }

  //Customer function
  loginCustomer(context, String email, String password) async {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    loading();
    uiProvider.updatePageControllerSelectedValue(0);
    try {
      UserCredential loginResponse = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await saveToSharedPreferences(
          sharedPrefCustomerUid, loginResponse.user!.uid);
      await saveToSharedPreferences(sharedPrefSellerUid, null);
    } catch (error) {
      log("$error");
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
    Future<String> downloadUrl =
        uploadUserImageToFirebase(imageFile!, sellerProfileImageDirectory);
    // Future<String> is need to be set in string data type.
    String imageDownloadUrl = await downloadUrl;
    //Create cloud database with a collection name user and set fields fullName, email, imageFile who are signUP.
    await firestore
        .collection(sellersDirectory)
        .doc(userCredential.user!.uid)
        .set({
      sellerCollectionFieldSid: userCredential.user!.uid,
      sellerCollectionFieldFullName: fullName,
      sellerCollectionFieldEmail: email,
      sellerCollectionFieldImageFile: imageDownloadUrl,
      sellerCollectionFieldPhoneNumber: '',
      sellerCollectionFieldAddress: ''
    });
    dismissLoading();
  }

  //Seller function
  loginSeller(context, String email, String password) async {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    loading();
    uiProvider.updatePageControllerSelectedValue(0);
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
    var collectionReference =
        FirebaseFirestore.instance.collection(customersDirectory);
    var profileData = collectionReference.doc(userJwt).get();
    return profileData;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> userSellerInfo() async {
    loading();
    dynamic jwt = await readFromSharedPreferences(sharedPrefSellerUid);
    String userJwt = jwt;
    var collectionReference =
        FirebaseFirestore.instance.collection(sellersDirectory);
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
