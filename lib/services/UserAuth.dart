import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;

  registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCreds = await _fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("after registration ${userCreds.user!.email}");
      _StoreUserDetails(name: name, email: email, password: password);
    } catch (err) {
      print("found $err while registering user");
    }
  }

  _StoreUserDetails({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, String> userLoginDetails = {
      "name": name,
      "email": email,
      "password": password,
    };

    try {
      await _fireStoreDB.collection("usersDB").doc(email).set(userLoginDetails);
    } catch (error) {
      print("while entering Data:\nFound: $error");
    }
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential loginCreds = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(loginCreds.user!.email);
      return loginCreds.user;
    } catch (err) {
      print("found while login $err");
      return null;
    }
  }

  googleLogIn() async {
    try {
      GoogleSignInAccount? gAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication gAuth = await gAccount!.authentication;
      AuthCredential creds = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );
      UserCredential googleUserCreds =
          await _fireAuth.signInWithCredential(creds);
    } catch (err) {
      print("found while google signin $err");
    }
  }
}
