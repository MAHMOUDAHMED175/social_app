

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/components/constatnce.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/models/create_users.dart';
import 'package:social_app/models/message_chat.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/settings/settings.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(SocialLayoutInitialState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);
  SocialCreateUserModel usermodel;
/*

 ببعت اشغارات من ال postman
  {
    //دا التوكن اللى باخده من الفايربيز
    // هنا ممكن استخدم زرار يبعت اشعارات للناس اللى عايزه اشعارات بس وهكتبها مكان التوكن بالشكل دا  topics/اسم الزرار/
    //"to":/topics/subscripe",
    "to":"diePoApoRpS4P46BQWTN2f:APA91bGrsCaFTjfI3mYJtwsOwZ7LisHhz6rNEAO2iPEJwn5PA9wQUdsdW9skDP6D7sy_-Vi4AuEE1QfuYebTMpo3ecv_5JdxzIVyAtxBAJo4etce5ngcgE8jCHSSJJ9etW8uUIzEZslv",
    "notification": {
        "title": "صلى على محمد",
        "body": "اللهم صلى وسلم وبارك على سيدنا محمد",
        "sound": "default"
    },
    "android": {
        "priority": "HIGH",
        "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
            "default_sound": true,
            "default_vibrate_timings":true,
            "default_light_settings":true
        }
    },
    "data": {
        "type": "order",
        "id": "87",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
    }
}


  */
  Future<void> getUserData()async{
    emit(SocialLayoutLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(uid).get()
        .then((value) {

        print(value.data());

      emit(SocialLayoutSuccessState());
      usermodel = SocialCreateUserModel.fromJson(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLayoutErrorState(error));
    });
  }

  int currentIndex = 1;
  List<Widget> screen = [
    Feeds(),
    Chats(),
    Setting(),
  ];

  void changeIndex(int index) {
    if(index==0)
    {      emit(o());

    getPosts();
      emit(o());

    }
    if(index==1)
    {      emit(p());

    getAllUsers();
      emit(p());
    }
    if(index==2)
    {      emit(s());

    getUserData();
      emit(s());
    }
    currentIndex = index;
    emit(SocialLayoutChangButtomNavState());
  }

  List<String> titels = [
    "Feeds",
    "Chats",
    "Setting",
  ];
File profileImage;
final picker=ImagePicker();
  Future<void> getProfileImage()async {
    var pickedFile=await picker.
    pickImage(source: ImageSource.gallery);

    if(pickedFile!=null)
    {
      profileImage=File(pickedFile.path);
      emit(SocialProfileImageSuccess());
    }
    else {
      print('No image selected ');
      emit(SocialProfileImageError());
    }

  }



  File coverImage;
  Future<void> getcoverImage()async {
    var pickedFile=await picker.pickImage(source:ImageSource.gallery);

    if(pickedFile!=null)
    {
      coverImage=File(pickedFile.path);
      emit(SocialCoverImageSuccess());
    }
    else {
      print('No image selected ');
      emit(SocialCoverImageError());
    }

  }


  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }){
    emit(SocialLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
    //https://firebasestorage.googleapis.com/v0/b/social-app-9ed43.appspot.com/o/IMG_20211220_110536_163.png
    //هنا بقسم على حسب الملفات الملف الاول بداخله ملف والملف بداخله ملف تانى وهكذا
    //وبعدين باخد مسار الصوره اللى معايا فى ال profileImage  وبعدين هاخد من بعد اخر سلاش / فى ال url
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
    //هنا علشان ارفع الصوره
        .putFile(profileImage)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        // emit(SocialUploadProfileImageSuccess());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio,image: value);
      }).catchError((){

        emit(SocialUploadProfileImageError());
      });

    }).catchError((error){

      emit(SocialUploadProfileImageError());
    });

  }





  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }){
    emit(SocialLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
    //https://firebasestorage.googleapis.com/v0/b/social-app-9ed43.appspot.com/o/IMG_20211220_110536_163.png
    //هنا بقسم على حسب الملفات الملف الاول بداخله ملف والملف بداخله ملف تانى وهكذا
    //وبعدين باخد مسار الصوره اللى معايا فى ال profileImage  وبعدين هاخد من بعد اخر سلاش / فى ال url
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
    //هنا علشان ارفع الصوره
        .putFile(coverImage)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        // emit(SocialUploadCoverImageSuccess());

        print(value);
        updateUserData(
            name: name, phone: phone, bio: bio,cover: value);
      }).catchError((){

        emit(SocialUploadCoverImageError());
      });

    }).catchError((error){

      emit(SocialUploadCoverImageError());
    });

  }


// void updateProfileImages({
//   @required String name,
//   @required String phone,
//   @required String bio,
// }){
//     emit(SocialLoadingStates());
//     if(profileImage !=null)
//       {
//         uploadProfileImage();
//       }else if(coverImage !=null)
//         {
//           uploadCoverImage();
//         } else if(profileImage !=null && coverImage !=null)
//     {
//
//     }else{
//
//       updateUserData(
//         name: name,
//         bio: bio,
//         phone: phone,
//       );
//
//     }
//
// }

void updateUserData({
  @required String name,
  @required String phone,
  @required String bio,
  String image,
  String cover,
}){
    emit(SocialLoadingStates());
  SocialCreateUserModel model=SocialCreateUserModel(
    name: name,
    phone: phone,
    bio: bio,
    image: image??usermodel.image,
    cover: cover??usermodel.cover,
    email: usermodel.email,
    password: usermodel.password,
    uid: uid,
    isEmailVerify: false,
  );

  FirebaseFirestore.instance.collection('users').doc(usermodel.uid).update(
      model.toMap()
  ).then((value) {
    getUserData();
  }).catchError((error){
    emit(SocialUpdateProfileErrorStates());
  });
}





































  File postImage;
  Future<void> getPostImage()async {
    var pickedFile=await picker.pickImage(source:ImageSource.gallery);

    if(pickedFile!=null)
    {
      postImage=File(pickedFile.path);
      emit(SocialPostImageSuccess());
    }
    else {
      print('No image selected ');
      emit(SocialPostImageError());
    }

  }




  void uploadPostImage({
    @required String uid,
    @required String dateTime,
    @required String text,
  }){
    emit(SocialCreatePostLoadingImage());
    firebase_storage.FirebaseStorage.instance.ref()
    //https://firebasestorage.googleapis.com/v0/b/social-app-9ed43.appspot.com/o/IMG_20211220_110536_163.png
    //هنا بقسم على حسب الملفات الملف الاول بداخله ملف والملف بداخله ملف تانى وهكذا
    //وبعدين باخد مسار الصوره اللى معايا فى ال profileImage  وبعدين هاخد من بعد اخر سلاش / فى ال url
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
    //هنا علشان ارفع الصوره
        .putFile(postImage)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,


        );

      }).catchError((){
        emit(SocialCreatePostImageError());
      });
    }).catchError((error){
      emit(SocialCreatePostImageError());
    });
  }



  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }){
    emit(SocialCreatePostLoadingImage());

    PostModel model=PostModel(
      name: usermodel.name,
      image: usermodel.image,
      uid: usermodel.uid,
      text: text,
      dateTime: dateTime,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap()
    ).then((value){
      emit(SocialCreatePostImageSuccess());
    }).catchError((error){
      emit(SocialCreatePostImageError());
    });
  }



void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageError());
}

List<PostModel> posts=[];
  List<String> postsId=[];
List<int> likes=[];
List<int> comments=[];
  void getPosts(){
  //emit(SocialGetPostsLoadingState());

  FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
         value.docs.forEach((element) {
           element.reference
           .collection('comments')
           .get().then((value) {
             comments.add(value.docs.length);
           }).catchError((error){});
           element.reference
           .collection('likes')
           .get().then((value) {
             likes.add(value.docs.length);
             postsId.add(element.id);
             posts.add(PostModel.fromJson(element.data()));

           }).catchError((error){

           });});
         emit(SocialGetPostsSuccessState());

    }).catchError((error){

      emit(SocialGetPostsErrorState(error.toString()));
    });
}


// هعمل اعجاب لبوست واحد بس podtId واحد بس
void postsLike(String  postId){

  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(usermodel.uid)
      .set({
    'likes':true
  }).then((value) {

    emit(SocialLikePostsSuccessState());

  }).catchError((error){

    emit(SocialLikePostsErrorState(error.toString()));
  });

}

void postComments(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(usermodel.uid)
        .set({
      'comments':true
    }).then((value){
      emit(SocialCommentsPostsSuccessState());
    }).catchError((error){
      emit(SocialCommentsPostsErrorState(error.toString()));
    });
}


List<SocialCreateUserModel> users=[];
void getAllUsers(){
  emit(SocialGetAllUsersLoadingState());
  // علسان ميستدعيش اكتر من مره ويكرر ال users
  if(users.length==0) {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            // علشان ميجبش اسمى مع الناس اللى هعمل معاهم دردشه chat
            //if(element.data()['uid']!=usermodel.uid)
              users.add(SocialCreateUserModel.fromJson(element.data()));
            emit(SocialGetAllUsersSuccessState());
          });

    }).catchError((error){
      emit(SocialGetAllUsersErrorState(error.toString()));


    });
  }
  }








  File chatImage;
  Future<void> getChatImage()async {
    var pickedFile=await picker.pickImage(source:ImageSource.gallery);

    if(pickedFile!=null)
    {
      chatImage=File(pickedFile.path);
      emit(SocialChatImageSuccess());
    }
    else {
      print('No image selected ');
      emit(SocialPostImageError());
    }

  }


  void uploadChatImage(){
    emit(SocialChatImageLoadingImage());
    firebase_storage.FirebaseStorage.instance.ref()
    //https://firebasestorage.googleapis.com/v0/b/social-app-9ed43.appspot.com/o/IMG_20211220_110536_163.png
    //هنا بقسم على حسب الملفات الملف الاول بداخله ملف والملف بداخله ملف تانى وهكذا
    //وبعدين باخد مسار الصوره اللى معايا فى ال profileImage  وبعدين هاخد من بعد اخر سلاش / فى ال url
        .child('images/${Uri.file(chatImage.path).pathSegments.last}')
    //هنا علشان ارفع الصوره
        .putFile(chatImage)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        print(value);
        sendMessage( image: value);
      }).catchError((){
        emit(SocialChatImageError());
      });
    }).catchError((error){
      emit(SocialChatImageError());
    });
  }


  void sendMessage({
  @required String receiver,
  @required String dateTime,
  @required String text,
  String image,
}){
  MessageModel model =MessageModel(
    text:text,
    image: image,
    sender:usermodel.uid,
    receiver:receiver,
    dateTime:dateTime,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(usermodel.uid)
      .collection('chats')
      .doc(receiver)
      .collection('message')
      .add(model.toMap()).then((value) {
    emit(SocialSendMessageSuccessState());
  }).catchError((error){
    emit(SocialSendMessageErrorState());
  });


  FirebaseFirestore.instance
      .collection('users')
      .doc(receiver)
      .collection('chats')
      .doc(usermodel.uid)
      .collection('message')
      .add(model.toMap()).then((value) {
    emit(SocialSendMessageSuccessState());
  }).catchError((error){
    emit(SocialSendMessageErrorState());
  });
}


  List<MessageModel> messages=[];

void getMessage({
  @required String receiver,
}) {
  //هتصفر الداتا علشان الرسايل متتكررش تانى

  FirebaseFirestore.instance
      .collection('users')
      .doc(usermodel.uid)
      .collection('chats')
      .doc(receiver)
      .collection('message')
      .orderBy('dateTime')
      //دى يعنى stream او تدفق من الرسايل والبيانات ورى بعض وطابور من البيانات وعامله زى الطابور المفتوح
      .snapshots()
      //دى علشان يسمع لكل حاجه بتحصل كلمه كلمه
      .listen((event) {
    messages=[];

    event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
        });
        emit(SocialGetMessageSuccessState());
  });
}




















  void removeChatImage(){
    chatImage=null;
    emit(SocialRemoveChatImageError());
  }
















































































































}
