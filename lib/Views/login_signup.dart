import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lexis/Views/palette.dart';

import 'LogoComponent.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = false;
  String name = "";
  bool changeText = false;
  String email = "";
  String pass = "";

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 330,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_background5.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF00587a).withOpacity(.87),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LogoComponent(letter: "L", color: Color(0xFFb786f7),),
                        LogoComponent(letter: "E", color: Color(0xFFd95959),),
                        LogoComponent(letter: "X", color: Color(0xFF18c94d),),
                        LogoComponent(letter: "I", color: Color(0xFFe8ca05),),
                        LogoComponent(letter: "S", color: Color(0xFFf28ad6),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    RichText(
                      text: TextSpan(
                          text: isSignupScreen ? "Welcome" : "",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? " $name" : "",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Sign Up to Continue"
                          : "Login to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: isSignupScreen ? 240 : 270,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isSignupScreen ? 405 : 285,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                //physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Form(
              key: _formKeyLogin,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.mail),
                        hintText: "Enter e-mail",
                        labelText: "E-mail",
                        hintStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        labelStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))
                    ),
                    autofillHints: [AutofillHints.email],
                    onChanged: (value){

                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "E-mail cant be empty!";
                      }
                      else if(!EmailValidator.validate(email)){
                        return "Plase enter a valid e-mail";
                      }
                      else return null;
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35)
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.lock_circle),
                          hintText: "Enter Password",
                          labelText: "Password",
                          hintStyle: TextStyle(
                              color: Palette.textColor1
                          ),
                          labelStyle: TextStyle(
                              color: Palette.textColor1
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))
                      ),
                      onChanged: (value){

                        setState(() {
                          pass = value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password cant be empty!";
                        }
                        else if(value.length < 6) return "Password must be consist of 6 or more characters";
                        else return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Form(
              key: _formKeySignup,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.profile_circled),
                        hintText: "Enter username",
                        labelText: "Username",
                        hintStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        labelStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        //border: InputBorder.none
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))
                    ),
                    onChanged: (value){

                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  //),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.mail),
                        hintText: "Enter e-mail",
                        labelText: "E-mail",
                        hintStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        labelStyle: TextStyle(
                            color: Palette.textColor1
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))
                    ),
                    autofillHints: [AutofillHints.email],
                    onChanged: (value){

                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "E-mail cant be empty!";
                      }
                      else if(!EmailValidator.validate(email)){
                        return "Plase enter a valid e-mail";
                      }
                      else return null;
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35)
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.lock_circle),
                          hintText: "Enter Password",
                          labelText: "Password",
                          hintStyle: TextStyle(
                              color: Palette.textColor1
                          ),
                          labelStyle: TextStyle(
                              color: Palette.textColor1
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))
                      ),
                      onChanged: (value){

                        setState(() {
                          pass = value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password cant be empty!";
                        }
                        else if(value.length < 6) return "Password must consist of 6 or more characters";
                        else return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: isSignupScreen ? 600 : 510,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: !changeText? Color(0xFF00587a): Colors.green,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              // if(isSignupScreen? _formKeySignup.currentState!.validate() : _formKeyLogin.currentState!.validate()) {
              //   setState(() {
              //     changeText = true;
              //   });
              //   isSignupScreen? auth.register(context, email, pass) : auth.login(context, email, pass);
              // }
            },
          )
              : Center(),
        ),
      ),
    );
  }
}