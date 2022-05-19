import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';
import 'package:smart_scheduler_marked/pages/homeStateChange.dart';
import 'package:smart_scheduler_marked/pages/login.dart';
import 'package:smart_scheduler_marked/user_model/user_model.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder:(_, AsyncSnapshot<User?> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final User? user = snapshot.data;
            return user == null ? LoginScreen(): HomeScreen();
          }else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
