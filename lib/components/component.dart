




import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function suffixPressd,validate,
  bool isPassword=false,
  Function submit,
  IconData suffixIcon,
  @required String hintText,labelText,
  @required IconData prefix,
})=>TextFormField(
  keyboardType:type,
  controller: controller,
  obscureText: isPassword,
  onFieldSubmitted: submit,
  validator:validate,
  decoration: InputDecoration(
    prefixIcon:Icon(prefix),
    hintText: hintText,
    suffixIcon: IconButton(
      onPressed:suffixPressd ,
      icon:Icon(suffixIcon),

    ),
    labelText: labelText,
    border: const OutlineInputBorder(),
  ),
);


Widget myDivider()=>Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 35.0,
      end: 30,
    ),
  child: Container(
    height: 1.0,
    color: Colors.grey,
  ),
);


Widget defaultButton({
  @required Function onPressed,
  @required String text,
  bool isUppercase=true,
})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(
      //color: Colors.blue,
      borderRadius: BorderRadius.circular(20.0),
    //تدرج الوان
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
      Colors.orange,
      Colors.red,
      Colors.tealAccent,
    ]),
  ),
  child:MaterialButton(
    child:Text(
      isUppercase?text.toUpperCase():text,
      style: const TextStyle(
          color: Colors.white
      ),
    ),
    onPressed: (){
      onPressed();
    },
  ),
);


void navigateAndFinish(context ,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder:(context)=> widget
    ),
        (route) => false
);

void navigateTo(context ,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context)=> widget
    ),
);
void showToast({
  @required String text,
  @required ToastStates state,
})
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 15.0
  );

}

enum ToastStates{SUCCECC,ERROR,WARNING}

Color toastColor(ToastStates state){

  Color color;
  switch(state){

    case ToastStates.SUCCECC:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
  }
  return color;


}


Widget defaultBar({
  @required BuildContext context,
  String titleText,
  @required List<Widget> action,
})=>AppBar(
  titleSpacing: 5.0,
  actions: action,
  elevation: 0,
  backgroundColor: Colors.white,
  leading:IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,),

    ),
  title: Text(
     titleText,
    style: TextStyle(
      color: Colors.black
    ),
  ),

);
