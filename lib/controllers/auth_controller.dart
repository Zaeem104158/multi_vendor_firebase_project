import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/login_customer_account_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/email_verification_screen/email_verification_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/login_seller_account_screen.dart';
import 'package:firebase_multi_vendor_project/views/auth/seller/signup_seller_account.dart';
import 'package:firebase_multi_vendor_project/views/home/bottom_widgets/customer_bottom_widget_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/bottom_widgets/seller_bottom_widget_screen.dart.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AuthController extends ChangeNotifier {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  final TextEditingController fullNameTextEditingController =
      TextEditingController();

  String _fullName = "";
  String _email = "";
  String _password = "";
  File? _image;
  final picker = ImagePicker();
  final FocusNode focusNode = FocusNode();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  String get fullName => _fullName;

  void setFullNameValue(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get email => _email;

  void setEmailValue(String value) {
    _email = value;
    notifyListeners();
  }

  String get password => _password;

  void setPasswordValue(String value) {
    _password = value;
    notifyListeners();
  }

  bool get isSignUpSubmitButtonVisible {
    bool validate;
    _fullName.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty
        ? validate = true
        : validate = false;

    return validate;
  }

  bool get isLoginSubmitButtonVisible {
    bool validate;
    _email.isNotEmpty && _password.isNotEmpty
        ? validate = true
        : validate = false;

    return validate;
  }

  bool get isForgetPasswordSubmitButtonVisible {
    bool validate;
    _email.isNotEmpty ? validate = true : validate = false;

    return validate;
  }

  clearAll() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    fullNameTextEditingController.clear();
    _email = "";
    _password = "";
    _fullName = "";
    _image = null;
    notifyListeners();
  }

  File? get image => _image;

  void setImage(File? image) {
    _image = image;
    notifyListeners();
  }

  //! Get image to ui for customer and seller
  Future getImage(context, ImageSource source,
      {bool isMultipleImages = false}) async {
    try {
      if (!isMultipleImages) {
        final pickedFile = await picker.pickImage(source: source);

        if (pickedFile != null) {
          setImage(File(pickedFile.path));
        } else {
          showSnack(
              context, "${AppLocalizations.of(context)!.no_image_selected}}");
        }
      } else {
        final pickedFiles = await picker.pickMultiImage();

        if (pickedFiles.length != 0) {
          // setMulipleImagesList(pickedFiles);
        } else {
          showSnack(
              context, "${AppLocalizations.of(context)!.no_image_selected}}");
          ;
        }
      }
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }

    notifyListeners();
  }

  //! Customer and seller image upload in firebase storage.
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

  //! Customer
  signUpCustomer(context, String fullName, String email, String password,
      File? imageFile) async {
    try {
      loading();
      //SingnUP method
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified == false) {
        await user.sendEmailVerification();
      }
      //Upload image url into Firebase Storage.
      Future<String> downloadUrl =
          uploadUserImageToFirebase(imageFile!, customerProfileImageDirectory);
      // Future<String> is need to be set in string data type.
      String imageDownloadUrl = await downloadUrl;
      //Create cloud database with a collection name user and set fields fullName, email, imageFile who are signUP.
      log('${emailTextEditingController.text} ${passwordTextEditingController.text}');
      saveToSharedPreferences('currentEmail', emailTextEditingController.text);
      saveToSharedPreferences(
          'currentPassword', passwordTextEditingController.text);
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
      closeSoftKeyBoard();

      dismissLoading();
      showMessage(AppLocalizations.of(context)!.account_create_successfully,
          isToast: true);
      Timer(Duration(seconds: 1), () {
        navigationPush(context,
            removeUntil: false, screenWidget: EmailVerificationScreen());
      });
      dismissLoading();
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }
    notifyListeners();
  }

  Future<bool> getEmailVerified(context,
      {String? email, String? password}) async {
    bool isEmailVerified = false;

    if (email != '' && password != '') {
      UserCredential loginResponse = await auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      isEmailVerified = await loginResponse.user!.emailVerified;
    } else {
      showMessage(
        AppLocalizations.of(context)!.something_went_wrong,
        isToast: false,
      );
    }
    return isEmailVerified;
  }

  loginCustomer(context, String email, String password) async {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    uiProvider.updateBottomNavigationBarSelectedValue(0);

    try {
      loading();
      UserCredential loginResponse = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("$loginResponse");

      if (loginResponse.user!.emailVerified == true) {
        await saveToSharedPreferences(
            sharedPrefCustomerUid, loginResponse.user!.uid);
        await saveToSharedPreferences(sharedPrefSellerUid, null);
        closeSoftKeyBoard();
        clearAll();
        dismissLoading();
        Timer(Duration(seconds: 1), () {
          navigationPush(context,
              removeUntil: false, screenWidget: CustomerBottomWidgetScreen());
        });
      } else {
        Timer(Duration(seconds: 1), () {
          navigationPush(context,
              removeUntil: true, screenWidget: EmailVerificationScreen());
        });
      }
      dismissLoading();
    } catch (error) {
      log("$error");
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }
    notifyListeners();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> userCustomerInfo() async {
    var profileData;
    try {
      dynamic jwt = await readFromSharedPreferences(sharedPrefCustomerUid);
      String userJwt = jwt;
      var collectionReference =
          FirebaseFirestore.instance.collection(customersDirectory);
      profileData = collectionReference.doc(userJwt).get();
    } catch (error) {
      showMessage("$error", isToast: false);
    }

    notifyListeners();
    return profileData;
  }

  TextEditingController updatePhoneNumberEditingController =
      TextEditingController();
  TextEditingController updateAddressEditingController =
      TextEditingController();
  TextEditingController updateFullNameEditingController =
      TextEditingController();
  void updateCustomerInfo({Map<Object, Object?>? data}) async {
    dynamic jwt = await readFromSharedPreferences(sharedPrefCustomerUid);
    String userJwt = jwt;
    var collectionReference =
        FirebaseFirestore.instance.collection(customersDirectory);
    if (data != null || data != "") {
      try {
        loading();
        await collectionReference.doc(userJwt).update(data!);
        dismissLoading();
        updatePhoneNumberEditingController.clear();
        updateAddressEditingController.clear();
        updateFullNameEditingController.clear();
        showMessage("Successfully updateed", isToast: true);
      } catch (error) {
        dismissLoading();
        showMessage("$error", isToast: false);
      }
    } else {}
    notifyListeners();
  }

  void deleteThenUpdateImage(context, {String? imageFilePath}) async {
    String fileUrl = imageFilePath!; // Replace with the actual file URL or path
    Reference storageReference = FirebaseStorage.instance.refFromURL(fileUrl);
    storageReference.delete();

    getImage(context, ImageSource.camera);
    Future.delayed(Duration(seconds: 30), () async {
      Future<String> downloadUrl =
          uploadUserImageToFirebase(image!, customerProfileImageDirectory);
      String imagePath = await downloadUrl;
      Map<Object, Object?> data = {
        customersCollectionFieldImageFile: imagePath
      };
      updateCustomerInfo(data: data);
    });

    notifyListeners();
  }

  Future<void> logoutCustomer(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      loading();
      clearAll();
      await auth.signOut();
      await saveToSharedPreferences(sharedPrefCustomerUid, null);
      navigationPush(context,
          removeUntil: false, screenWidget: CustomerSignUpScreen());
      dismissLoading();
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }

    notifyListeners();
  }

  //!Seller

  signUpSeller(context, String fullName, String email, String password,
      File? imageFile) async {
    try {
      loading();
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
      closeSoftKeyBoard();
      clearAll();
      dismissLoading();
      showMessage(AppLocalizations.of(context)!.account_create_successfully,
          isToast: true);
      Timer(Duration(seconds: 1), () {
        navigationPush(context,
            removeUntil: false, screenWidget: SellerLoginScreen());
      });
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }
    notifyListeners();
  }

  loginSeller(context, String email, String password) async {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    uiProvider.updateBottomNavigationBarSelectedValue(0);
    try {
      loading();
      UserCredential loginResponse = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await saveToSharedPreferences(
          sharedPrefSellerUid, loginResponse.user!.uid);
      await saveToSharedPreferences(sharedPrefCustomerUid, null);

      closeSoftKeyBoard();
      clearAll();
      dismissLoading();
      Timer(Duration(seconds: 1), () {
        navigationPush(context,
            removeUntil: false, screenWidget: SellerBottomWidgetScreen());
      });
      dismissLoading();
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }
    notifyListeners();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> userSellerInfo() async {
    var profileData;
    try {
      dynamic jwt = await readFromSharedPreferences(sharedPrefSellerUid);
      String userJwt = jwt;
      var collectionReference =
          FirebaseFirestore.instance.collection(sellersDirectory);
      profileData = collectionReference.doc(userJwt).get();
    } catch (error) {
      showMessage("$error", isToast: false);
    }
    notifyListeners();
    return profileData;
  }

  Future<void> logoutSeller(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      loading();
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
      await auth.signOut();
      await saveToSharedPreferences(sharedPrefSellerUid, null);
      navigationPush(context, screenWidget: SellerSignUpScreen());
      dismissLoading();
    } catch (error) {
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}$error",
          isToast: false);
    }
    notifyListeners();
  }

  Future<void> resetPassword(context, user, String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      loading();
      await _auth.sendPasswordResetEmail(email: email);
      clearAll();
      dismissLoading();
      showMessage(
          "${AppLocalizations.of(context)!.verification_code_has_sent_to_the_mail}",
          isToast: true);
      user == "customer"
          ? navigationPush(context,
              removeUntil: false, screenWidget: CustomerLoginScreen())
          : navigationPush(context,
              removeUntil: false, screenWidget: SellerLoginScreen());
      // Password reset email sent successfully
    } catch (error) {
      // An error occurred while attempting to send password reset email
      showMessage("${AppLocalizations.of(context)!.something_went_wrong}",
          isToast: false);
    }
    notifyListeners();
  }
}
