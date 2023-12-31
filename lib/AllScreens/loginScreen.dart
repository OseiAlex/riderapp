import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/AllWidgets/progressDialog.dart';
import 'package:riderapp/main.dart';
import 'package:riderapp/AllScreens/mainscreen.dart' as homeScreen;
import 'package:riderapp/AllScreens/registrationScreen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0),
              Image(
                  image: AssetImage("images/logo.png"),
                  width: 390.0,
                  height: 250.0,
                  alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Login as a Rider",
               style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
               textAlign: TextAlign.center
              ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      TextField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 10.0
                          ),
                        ),
                      ),
                      SizedBox(height: 1.0,),
                      TextField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 10.0
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)
                            )
                          ),
                        onPressed: () {
                          if (!emailTextEditingController.text.contains("@")){
                            displayToastMessage("Email address is not Valid!", context);
                          }
                          else if (passwordTextEditingController.text.isEmpty){
                            displayToastMessage("Password is mandatory.", context);
                          }
                          else{
                            loginAuthenticateUSer(context);
                          }
                        },
                         child:
                        Container(
                          color: Colors.yellow,
                          height: 50.0,

                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold", color: Colors.white),
                              ),
                          ),
                        ),
                      ),

                      TextButton(
                          onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                          },
                          child: Text("Do not have an Account? Register Here.",)
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAuthenticateUSer(BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(message: "Authenticating, Please Wait...",);
      },
    );

    final User? firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text, password: passwordTextEditingController.text
      ).catchError((errMsg){
        Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null){
      // Save user info to database
      usersRef.child(firebaseUser.uid).once().then((DatabaseEvent snap){
        if (snap != null){
          Navigator.pushNamedAndRemoveUntil(context, homeScreen.MainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged-in.", context);
        }
        else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user. Please create new account.", context);
        }
      });
    }
    else{
      Navigator.pop(context);
      displayToastMessage("Error Occured, can not sign-in", context);
      }
    }
    displayToastMessage(String message, BuildContext context){
      Fluttertoast.showToast(msg: message);
  }
}

class MainScreen {
}

