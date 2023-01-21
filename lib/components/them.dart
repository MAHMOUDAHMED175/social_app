






import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData light=ThemeData(
  primaryColor: Colors.orange,
  hintColor: Colors.grey,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[200],
  textTheme:TextTheme(
    bodyText2:
   TextStyle(
    fontSize: 28.0,
     fontStyle: FontStyle.italic,


  ),
  ),
    appBarTheme: AppBarTheme(
      color: HexColor('#BE5C1A'),
systemOverlayStyle: SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.light,
  statusBarColor: HexColor('#BE5C1A'),
  systemNavigationBarColor: HexColor('#BE5C1A'),
),
      titleSpacing: 16.0,
      titleTextStyle: TextStyle(
        fontSize: 16.0,
        fontStyle: FontStyle.italic,


      ),
  )
);





ThemeData dark=ThemeData(

  scaffoldBackgroundColor: HexColor('375563'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.withOpacity(0.28),
        statusBarIconBrightness:Brightness.light
    ),
    backgroundColor:HexColor('375563'),
    elevation:0.0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    ),
    iconTheme:IconThemeData(
      color: Colors.white,
    ) ,
  ),

  textTheme: TextTheme(
    bodyText2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
  ),


);
