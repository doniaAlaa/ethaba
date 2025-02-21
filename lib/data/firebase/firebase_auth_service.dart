import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';


class AuthFirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      //log("Registering phone number $phoneNumber");
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      log('Error during phone verification: $e');
    }
  }

  Future<void> signInWithCredential({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      //log('User signed in successfully');
    } catch (e) {


      log('Error signing in with credential: $e');
      rethrow; // Rethrow the exception for handling in the controller
    }
  }




  Future<void> resendCode({
    required String phoneNumber,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    Function(FirebaseAuthException)? verificationFailed
  }) async {
    try {
      //log('Resending code to $phoneNumber');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: verificationFailed!,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      log('Error resending code: $e');
    }
  }
}
