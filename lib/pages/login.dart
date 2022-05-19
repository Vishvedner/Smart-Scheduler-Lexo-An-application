import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState(){
    super.initState();
    // lstOfTime = UserSimplePreferences.getListOfTime() ?? ['kl','kl1'];
  }

  final _formKey = GlobalKey<FormState>();

  Color colorName = Colors.black;
  Color colorNamep = Colors.black;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      child: Center(
                          child: Text(
                        'Welcome To Smart Scheduler',
                        style: TextStyle(
                          letterSpacing: -2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                    Image.asset('assets/robo.gif', scale: 1, width: 200,),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            height: 0.8, // 0,1 - label will sit on top of border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () => {
                              emailController.clear(),
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: InkWell(
                            //onTap: () => {passwordController1.clear(),},
                            child: Icon(
                              Icons.email,
                              color: colorName,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            height: 0.8, // 0,1 - label will sit on top of border
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () => {
                              passwordController.clear(),
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: InkWell(
                            //onTap: () => {passwordController1.clear(),},
                            child: Icon(
                              Icons.password,
                              color: colorNamep,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () async {
                            dynamic result =
                                await authService.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
                            if (result == null) {
                              print('error');
                              setState(() {
                                colorName = Colors.red;
                                colorNamep = Colors.red;
                              });
                            } else {
                              Navigator.pushNamed(context, '/');
                            }
                          },
                          child: Text('Login'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('If you don\'t have an account',
                      style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                      ),
                    ),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:  MaterialStateProperty.all<Color>(Colors.black),
                                  ),
                                  child: Text('Register'),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
