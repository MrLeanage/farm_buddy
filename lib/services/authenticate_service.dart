import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//create User obj based on firebase user
  User? userFromFirebaseUser(User? user){
    return user != null ?  user : null;
  }
  //auth change user stream
  Stream<User?> get user{
    print(userFromFirebaseUser);
    return firebaseAuth.authStateChanges();
  }

  //sign in Anon
  Future signInAnon() async{

    try{
      UserCredential credentialResult = await firebaseAuth.signInAnonymously();
      User? user = credentialResult.user;
      return userFromFirebaseUser(user);
    }catch( exception){
      print(exception.toString());
      return null;
    }
  }
///////////////////
  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    print('email is :'+email);
    print('password :' +password);
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return exception;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    print('email is :'+email);
    print('password :' +password);
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return exception;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await firebaseAuth.signOut();
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
}