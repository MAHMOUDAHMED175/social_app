


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_login/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() :super(InitiSocialLoginStates());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  bool isPasswordshowen=true;
  IconData icons=Icons.visibility_off;
  void ChangeVisibility(){
    isPasswordshowen=!isPasswordshowen;
    icons=isPasswordshowen?Icons.visibility_off:Icons.visibility;
    emit(ChangeVisibilitySocialLoginStates());
  }

  void UserLogin({
    @required String email,
    @required String password,
}){
     FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email??'',
        password: password,
    ).then((value) {
      print(value.user.uid);
      print(value.user.email);
      emit(SuccessSocialLoginStates(value.user.uid));
    }).catchError((error){

      emit(ErrorSocialLoginStates(error.toString()));
    });
  }




}