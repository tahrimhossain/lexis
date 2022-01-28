import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeText = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/images/login_background.jpg",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              children: [
                SizedBox(height: 200.0,),
                Text("Welcome $name",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                ),),
                SizedBox(height: 25.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: TextFormField(
                            cursorColor: Colors.tealAccent,
                            style: TextStyle(
                              color: Colors.white70
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.profile_circled, color: Colors.tealAccent),
                              hintText: "Enter Username",
                              labelText: "Username",
                              hintStyle: TextStyle(
                                  color: Colors.white54
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              border: InputBorder.none
                            ),
                            onChanged: (value){
                              name = value;
                              setState(() {

                              });
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return "Username cant be empty!";
                              }
                              else return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: TextFormField(
                            cursorColor: Colors.tealAccent,
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.white70,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.lock_circle, color: Colors.tealAccent,),
                                hintText: "Enter Password",
                                labelText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.white54
                                ),
                                labelStyle: TextStyle(
                                    color: Colors.white
                                ),
                                border: InputBorder.none
                            ),
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
                SizedBox(height: 40.0,),
                Material(
                  color: Colors.black,
                  borderRadius: changeText? BorderRadius.circular(80) : BorderRadius.circular(8),
                  child: InkWell(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 50,
                      width: changeText? 50 : 140,
                      alignment: Alignment.center,
                      child: changeText? Icon(Icons.done, color: Colors.white,) : Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: () async {
                      if(_formKey.currentState!.validate()) {
                        setState(() {
                          changeText = true;
                        });
                        await Future.delayed(Duration(seconds: 1));
                        await Navigator.pushNamed(context, "/home");
                        setState(() {
                          changeText = false;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
