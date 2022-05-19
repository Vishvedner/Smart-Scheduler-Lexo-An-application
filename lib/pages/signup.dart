import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';

import '../provider/user_simple_sharedPreferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override

  void initState(){
    super.initState();
   // lstOfTime = UserSimplePreferences.getListOfTime() ?? ['kl','kl1'];
  }


  final _formKey = GlobalKey<FormState>();

  Color colorName = Colors.black;
  Color colorNamep = Colors.black;
  Color colorNameu = Colors.black;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();

  String email = ' ';
  String password = ' ';
  String password1 = ' ';
  String username = ' ';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    //String error_message = 'password must be a 6 character long';
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h,),
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
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: userNameController,
                            decoration: InputDecoration(
                              labelText: "User Name",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                height: 0.8, // 0,1 - label will sit on top of border
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(
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
                                onTap: () => {userNameController.clear(),},
                                child: Icon(Icons.cancel,color: Colors.black,),
                              ),
                              prefixIcon: InkWell(
                                //onTap: () => {passwordController1.clear(),},
                                child: Icon(Icons.person,color: colorNameu,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: emailController,
                            validator: (emailController) {

                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                height: 0.8, // 0,1 - label will sit on top of border
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(
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
                                onTap: () => {emailController.clear(),},
                                child: Icon(Icons.cancel,color: Colors.black,),
                              ),
                              prefixIcon: InkWell(
                                //onTap: () => {passwordController1.clear(),},
                                child: Icon(Icons.email,color: colorName,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
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
                                borderSide:  BorderSide(
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
                                onTap: () => {passwordController.clear(),},
                                child: Icon(Icons.cancel,color: Colors.black,),
                              ),
                              prefixIcon: InkWell(
                                //onTap: () => {passwordController1.clear(),},
                                child: Icon(Icons.password,color: colorNamep,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: passwordController1,
                            obscureText: true,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                height: 0.8, // 0,1 - label will sit on top of border
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(
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
                                onTap: () => {passwordController1.clear(),},
                                child: Icon(Icons.cancel,color: Colors.black,),
                              ),
                              prefixIcon: InkWell(
                                //onTap: () => {passwordController1.clear(),},
                                child: Icon(Icons.password,color: colorNamep,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed:() async {
                                if(passwordController.text.length >= 6 && passwordController1.text.length >= 6 ){
                                  if(passwordController.text == passwordController1.text){
                                     dynamic result = await authService.createUserWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                     if(result == null){
                                       setState(() {

                                       });
                                      // error_message = 'email format not correct';
                                     }
                                     else{
                                       UserSimplePreferences.setUsername(userNameController.text);
                                       Navigator.pushNamed(context, '/');
                                     }
                                  }
                                  else{
                                    setState(() {

                                    });
                                  }
                                }
                                else{}


                                if(passwordController == null){
                                  setState(() {
                                    colorNamep = Colors.red;
                                  });
                                }

                                if(passwordController.text.length < 6){
                                  setState(() {
                                    colorNamep = Colors.red;
                                  });
                                }

                                if(passwordController.text != passwordController1.text){
                                  setState(() {
                                    colorNamep = Colors.red;
                                  });
                                }



                                  if (emailController == null){
                                  setState(() {
                                    colorName = Colors.red;
                                  });
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.toString())) {
                                  setState(() {
                                    colorName = Colors.red;
                                  });
                                }else{
                                  setState(() {
                                    colorName = Colors.black;
                                  });
                                }

                                if(userNameController.text.length <= 1){
                                  setState(() {
                                    colorNameu = Colors.red;
                                  });
                                }else{
                                  setState(() {
                                    colorNameu = Colors.black;
                                  });
                                }

                              },
                              child: Text('Register'),
                            ),
                          ),
                        ),
                        //Text(error_message),
                        SizedBox(height: 11.h,),

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('If you already have an account',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed:(){
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:  MaterialStateProperty.all<Color>(Colors.black),
                                  ),
                                  child: Text('Login'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
