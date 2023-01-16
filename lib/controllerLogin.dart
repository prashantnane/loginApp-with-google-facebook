import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './userDetailsModel.dart';

class ControllerLogin with ChangeNotifier {
  var googleSignInNow = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  UserDetails? userDetails;

  allowUserToLogin() async {
    this.googleSignInAccount = await googleSignInNow.signIn();

    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  allowUserToLogout() async {
    if (googleSignInAccount != null) {
      this.googleSignInAccount = await googleSignInNow.signOut();
    } else {
      await FacebookAuth.i.logOut();
    }

    userDetails = null;

    notifyListeners();
  }

  allowUserToLoginwithFB() async {
    var result = await FacebookAuth.instance.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData(
        fields: "email, name, picture.type(large)",
      );

      this.userDetails = new UserDetails(
        displayName: userData["name"],
        email: userData["email"],
        photoURL: userData["picture"]["data"]["url"] ?? " ",
      );
    }

    notifyListeners();
  }

  
  
}
