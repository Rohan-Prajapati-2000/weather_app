import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Screens/home_screen.dart';
import 'package:weather_app/Screens/login_screen.dart';
import 'package:weather_app/utils/utils.dart';


class SignUpScreen extends StatefulWidget{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String confirmPass = confirmPassController.text.trim();

    if(email=="" || pass=="" || confirmPass==""){
      Utils().toastMessage("Please fill in all the fields.");
      return;
    } else if(pass != confirmPass){
      Utils().toastMessage("Password does not match.");
      return;
    } else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);

        if(userCredential.user != null){
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        }

      } on FirebaseAuthException catch(error){
        Utils().toastMessage(error.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff212F3C),
                      Color(0xff2E4053)
                    ]
                )
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text("SignIn", style: TextStyle(fontSize: 30, color: Colors.orange)),
                    SizedBox(height: 20),

                    // Image.asset("assets/water_drop.png", height: 250, width: 250,),
                    // SizedBox(height: 20),


                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff212F3C),
                            Color(0xff2E4053)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                      ),
                      child: TextField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent, // Set to transparent to see the gradient background
                          hintText: 'Enter Email',
                          border: OutlineInputBorder( // Optional: for border
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff212F3C),
                            Color(0xff2E4053)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                      ),
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent, // Set to transparent to see the gradient background
                          hintText: 'Enter Password',
                          border: OutlineInputBorder( // Optional: for border
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff212F3C),
                            Color(0xff2E4053)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                      ),
                      child: TextField(
                        controller: confirmPassController,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent, // Set to transparent to see the gradient background
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder( // Optional: for border
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        createAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Optional: for rounded corners
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.yellow],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Optional: for rounded corners
                        ),
                        child: Container(
                          constraints: BoxConstraints(minWidth: 150.0, minHeight: 55.0), // Optional: set minimum button size
                          alignment: Alignment.center,
                          child: Text(
                            'SignIn',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 5),
                        InkWell(
                            onTap: (){
                              // Navigator.popUntil(context, (route) => route.isFirst);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text("Login", style: TextStyle(color: Colors.orange)))

                      ],
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}