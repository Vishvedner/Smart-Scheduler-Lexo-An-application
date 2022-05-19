import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:smart_scheduler_marked/user_model/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFormFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFormFirebase);
  }

  Future<String?>? getCurrentUID() async{
    String uid = (await _firebaseAuth.currentUser!).uid;
    return uid;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFormFirebase(credential.user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try{
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFormFirebase(credential.user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
