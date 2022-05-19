import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';
import 'package:smart_scheduler_marked/pages/login.dart';
import 'package:smart_scheduler_marked/pages/signup.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';
import 'package:smart_scheduler_marked/wrapper.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await UserSimplePreferences.init();
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
       .then((_) async {
     runApp(const MyApp());
   });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => SignupScreen(),
        },
      ),
    );
  }
}


