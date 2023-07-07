import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/AllScreens/loginScreen.dart';
import 'package:riderapp/AllWidgets/progressDialog.dart';
import 'package:riderapp/main.dart';
import 'package:riderapp/AllScreens/mainscreen.dart' as homeScreen;

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 20.0),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                  "Register as a Rider",
                  style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center
              ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      TextField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Name",
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
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
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
                        onPressed: () {
                          if (nameTextEditingController.text.length < 3){
                            displayToastMessage("Name must be at least 3 characters!", context);
                          }
                          else if (!emailTextEditingController.text.contains("@")){
                            displayToastMessage("Email address is not Valid!", context);
                          }
                          else if (phoneTextEditingController.text.isEmpty){
                            displayToastMessage("Phone number is mandatory!", context);
                          }
                          else if (passwordTextEditingController.text.length < 6){
                            displayToastMessage("Password must be at least 6 characters!", context);
                          }
                          else{
                            registerNewUser(context);
                          }
                         },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        )
                        ),
                        child:
                        Container(
                          color: Colors.yellow,
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold", color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      TextButton(
                          onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                          },
                          child: Text("Already have an Account? Login Here.",)
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
  void registerNewUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(message: "Creating Account, Please Wait...",);
      },
    );

    final User? firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text, password: passwordTextEditingController.text
      ).catchError((errMsg){
      Navigator.pop(context);
        displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null){
      // Save user info to database
      Map userDataMap = {
        "name": nameTextEditingController,
        "email": emailTextEditingController,
        "phone": phoneTextEditingController,
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congratulations, your account has been created.", context);
      Navigator.pushNamedAndRemoveUntil(context, homeScreen.MainScreen.idScreen, (route) => false);
    }
    else{
      // Error occurred. Display error message
      Navigator.pop(context);
      displayToastMessage("New user account has not been created.", context);
    }
  }

  displayToastMessage(String message, BuildContext context){
    Fluttertoast.showToast(msg: message);
  }
}

