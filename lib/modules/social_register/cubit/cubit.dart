
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/create_users.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInitiState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);




  void createUser({
  String name,
    String email,
    String password,
    String phone,
    String uid,
}){
    SocialCreateUserModel model=SocialCreateUserModel(
      email: email,
      name: name,
      phone: phone,
      password: password,
      uid: uid,
      // معرفتش متغيرات لل image ,cover,bio,isWmailVerify علشان هياخدوا قيمه علطول ومش هحتاجها من لايوزر لاول مره
      image:'https://fonts.freepiklabs.com/storage/7985/conversions/Cover-preview.jpg',
      cover: 'https://fonts.freepiklabs.com/storage/7985/conversions/Cover-preview.jpg',
      bio: "Write your bio..."??'',
      isEmailVerify: false,
    );

    FirebaseFirestore.instance.collection('users').doc(uid).set(
      model.toMap()
    ).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorState(error));
    });



  }
  void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      createUser(
        email: email,
        uid: value.user.uid,
        password: password,
        phone: phone,
        name: name,

      );/*علشان لما يخش على الloadingالمفروض يفضل يلف لما يسجل الدخول ولاكن لو سبت ال success مش هيلحق يلف علشان هيخش على ال success علطول ومش هيستنى يعمل create user فهمسح او اوقف ال success*/
      //emit(SocialRegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
    emit(SocialRegisterChangePassowrdVisibilityState());
  }


}