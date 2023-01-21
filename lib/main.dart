import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/Opserver.dart';
import 'package:social_app/components/cache_helper.dart';
import 'package:social_app/components/component.dart';
import 'package:social_app/components/constatnce.dart';
import 'package:social_app/layout/Social_Layout.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/modules/social_login/login.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
      print('on background');
      print(message.data.toString());
      showToast(text: 'اللهم صلى على الحبيب محمدا صلوات الله وسلامه عليه ', state: ToastStates.WARNING);
    }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token=  await FirebaseMessaging.instance.getToken();
  print(token);
// هيبعت اشعار ولاكن مش هيظهر فى التطبيق هيظهر فى ال console
// دى والتطبيق مفتوح
    FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: 'اللهم صلى سلم وبارك على سيدنا محمد', state: ToastStates.SUCCECC);
  });
  //  دى هيبعت اشعار
  //  دى والتطبيق فى ال background يعنى  لسه مفتوح  فى الخلفيه
  //ولما تدوس على الاشعار يفتح التطبيق
  //دى هتنفذ حاجه معينه لما التطبيق يفتح
  //زى مثلا اظهر showtoast

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app [[[[[[[[[[[[[[[[[[[[');

    print(event.data.toString());
    showToast(text: 'صلى على محمد', state: ToastStates.ERROR);

  });


  //دى والتطبيق مفتوح فى الخلفيه
  // دى هنفذ حاجه معينه والتطبيق فى الخلفيه زى مثلا اظهر  showtoast  على الشاشه الرئيسيه
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  await CachHelper.initial();
  Bloc.observer=MyBlocObserver();

  Widget widget;
  uid=CachHelper.getData(key: 'uid');
  if(uid !=null){
    widget=SocialLayout();
   }else{
    widget=SocialLogin();
   }
  runApp(MyApp(
    statrtWidget:widget,
  ));
}




class MyApp extends StatefulWidget {

  Widget statrtWidget;
  MyApp({
    @required this.statrtWidget,
});

  @override
  State<MyApp> createState() => _MyAppState();
}


// @override
// void initState() {
//   initialization();
// }
//
// void initialization() async {
//   // This is where you can initialize the resources needed by your app while
//   // the splash screen is displayed.  Remove the following example because
//   // delaying the user experience is a bad design practice!
//   // ignore_for_file: avoid_print
//   print('ready in 3...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('ready in 2...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('ready in 1...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('go!');
//   FlutterNativeSplash.remove();
// }

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return  MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context)=>SocialLayoutCubit()..getPosts()..getUserData(),

            ),
          ],
          child: BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
           listener:(context,state){},
           builder:(context,state){
             return MaterialApp(
             debugShowCheckedModeBanner: false,
             theme:ThemeData.light(),
    home:
     //SocialLayout(),
    widget.statrtWidget,

    );
    },
          ),
        );
  }
}
