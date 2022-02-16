import 'package:firebase_auth/firebase_auth.dart';
import 'package:lexis/Models/CustomUser.dart';
import 'package:lexis/Models/LogInWithEmailAndPasswordFailure.dart';
import 'package:lexis/Models/LogOutFailure.dart';
import 'package:lexis/Models/SignUpWithEmailAndPasswordFailure.dart';
class Authentication{

  final FirebaseAuth _auth;

  Authentication({FirebaseAuth ? auth}):_auth = auth ?? FirebaseAuth.instance;

  Stream<CustomUser> get user {
    return _auth.userChanges().map((User ? user) {
      if(user == null){
        return const CustomUser(id: '');
      }else{
        if(user.displayName == null){
          return CustomUser(id:user.uid ,email:user.email);
        }else{
          return CustomUser(id:user.uid ,name: user.displayName,email:user.email);
        }
      }
    });
  }

  CustomUser? getCurrentUser(){
    if(_auth.currentUser == null){
      return const CustomUser(id: '');
    }else{
      return CustomUser(id: _auth.currentUser!.uid,email: _auth.currentUser!.email);
    }
  }

  Future<void> signUp({required String name,required String email,required String password})async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser?.updateDisplayName(name);
      await _auth.currentUser?.reload();
    }on FirebaseAuthException catch (e){
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    }catch(_){
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logIn({required String email,required String password})async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    }catch(_){
      throw const LogInWithEmailAndPasswordFailure();
    }
  }


  Future<void> logOut()async{
    try{
      await _auth.signOut();
    }catch(_){
      throw LogOutFailure();
    }
  }

}