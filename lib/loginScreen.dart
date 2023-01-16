import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import './controllerLogin.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  loginUIController() {
    return Consumer<ControllerLogin>(builder: (context, model, child) {
      //if user already loggedIn
      if (model.userDetails != null) {
        return Center(
          //show user details
          child: isLoading
              ? CircularProgressIndicator()
              : alreadyLoggedInScreen(model),
        );
      }
      //if user not loggedIn
      else {
        //show NotLoggedIn screen
        return notLoggedInScreen();
      }
    });
  }

  notLoggedInScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 60, bottom: 40),
            child: Image.asset("assets/sparks.jpg"),
          ),
          Text(
            'Log into your Account',
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                isLoading = true;
                Provider.of<ControllerLogin>(context, listen: false)
                    .allowUserToLogin();
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  isLoading = false;
                });
              });
            }),
            child: Image.asset(
              "assets/google_image.png",
              width: 202,
            ),
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                isLoading = true;
                Provider.of<ControllerLogin>(context, listen: false)
                    .allowUserToLoginwithFB();
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  isLoading = false;
                });
              });
            }),
            child: Image.asset(
              "assets/fb.png",
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  alreadyLoggedInScreen(ControllerLogin model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15.0),
            // margin: EdgeInsets.all(40),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.blue[900],
              child: CircleAvatar(
                backgroundImage:
                    Image.network(model.userDetails!.photoURL ?? "").image,
                radius: 100,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 50,
            color: Colors.grey[800],
          ),
          Text(
            "NAME",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54,
                letterSpacing: 2.0),
          ),
          SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.userDetails!.displayName ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blue[900],
                    letterSpacing: 1.5),
              ),
              Icon(
                Icons.person,
                color: Colors.black54,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "E-MAIL",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54,
                letterSpacing: 2.0),
          ),
          SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.userDetails!.email ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[900],
                  letterSpacing: 0.5,
                ),
              ),
              Icon(
                Icons.email,
                color: Colors.black54,
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: ActionChip(
              backgroundColor: Colors.black87,
              avatar: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              label: Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: (() {
                Provider.of<ControllerLogin>(context, listen: false)
                    .allowUserToLogout();
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Sign In'),
      //   centerTitle: true,
      // ),
      body: loginUIController(),
    );
  }
}
