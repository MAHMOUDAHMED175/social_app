



import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
class SocialLayout extends StatelessWidget {
   SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialLayoutCubit(),
      child: BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SocialLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(

              title:  Text(
                cubit.titels[cubit.currentIndex],
                style: TextStyle(
                  fontFamily: "lora",
                    color: Colors.white,
                ),
              ),
              actions:[
                IconButton(onPressed: (){}, icon:Icon(Icons.notifications_active_outlined,color: Colors.white,)),
                IconButton(onPressed: (){}, icon:Icon(Icons.search_outlined,color: Colors.white)),
              ],
              backgroundColor:  HexColor('#BE5C1A'),
              elevation: 0,

            ),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              onTap: (index){
                cubit.changeIndex(index);
              },
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.brown,
              color:  HexColor('#BE5C1A'),
              height: 50.0,
              animationCurve: Curves.easeInCirc,
              animationDuration: const Duration(
                milliseconds: 20,
              ),
              index: cubit.currentIndex,
              items:<Widget> [
                 Icon(Icons.home,color: Colors.white,),
                 Icon(Icons.chat,color: Colors.white,),
                 Icon(Icons.settings,color: Colors.white,),

              ],
            ),
            /*ConditionalBuilder(
              condition: SocialLayoutCubit.get(context).model !=null,
              builder:(context)=> Column(
                children: [

                  if(!SocialLayoutCubit.get(context).model.isEmailVerify)
                    Container(
                    height: 60.0,
                    color: Colors.amber,
                    child: Padding(
                      padding:  const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0
                      ),
                      child: Row(
                        children: [
                           const Icon(Icons.notification_important_outlined),
                           const SizedBox(
                            width: 10.0,
                          ),
                           const Text(
                            "please very your email",
                          ),
                           const Spacer(),
                           const SizedBox(
                            width: 20.0,
                          ),
                          MaterialButton(
                            color: Colors.red.withOpacity(0.5),
                              onPressed: (){
                              FirebaseAuth.instance.currentUser.sendEmailVerification()
                                  .then((value) {
                                    showToast(text: 'check your mail', state: ToastStates.SUCCECC);
                              })
                                  .catchError((error){});
                              },
                              child:  const Text("send",
                          style: TextStyle(color: Colors.black),)

                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              fallback: (context)=> const Center(child: CircularProgressIndicator()),
            ),*/
          );
        },
      ),
    );
  }
}
