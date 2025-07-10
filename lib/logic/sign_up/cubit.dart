import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/sign_up/state.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit () : super (SignUpInitialState());

  Future signUp({required String userEmail, required String pass}) async {
    emit(SignUpLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: pass);
      userEmail;
      pass;
      emit(SignUpSuccessState());
    } catch (errorMassage) {
    emit(SignUpErrorState(errorMassage: errorMassage.toString()));
    }
  }
}