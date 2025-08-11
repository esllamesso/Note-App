import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/core/utils/shared_prefs_helper.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
      await SharedPrefsHelper.setIsLoggedIn(true);
    } on FirebaseAuthException catch (error) {
      String errorMessage;

      switch (error.code) {
        case 'user-not-found':
          errorMessage = ' This email is not registered';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        default:
          errorMessage = 'An error occurred during login';
      }

      emit(LoginErrorState(errorMassage: errorMessage));
    }
  }

  Future<void> continueWithGoogle() async {
    emit(LoginLoadingState());

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        emit(LoginErrorState(errorMassage:  'Google sign-in was canceled.'));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await SharedPrefsHelper.setIsLoggedIn(true);


      emit(LoginSuccessState());
    } catch (e) {
      print("Google Sign-In Error: $e");
      emit(LoginErrorState(errorMassage: e.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await SharedPrefsHelper.clear();
    emit(LoginInitialState());
  }
}
