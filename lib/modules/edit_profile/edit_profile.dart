import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/component.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/modules/social_login/login.dart';
class EditProfile extends StatelessWidget {
   EditProfile({Key key}) : super(key: key);
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder:(context,state){

        var userModel=SocialLayoutCubit.get(context).usermodel;
        var profileImage=SocialLayoutCubit.get(context).profileImage;
        var coverImage=SocialLayoutCubit.get(context).coverImage;
        nameController.text=userModel.name;
        bioController.text=userModel.bio;
        phoneController.text=userModel.phone;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,

            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new,size: 22.0,),color: Colors.black,),
            title: Text(
              'Edit My Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0
              ),
            ),
            titleSpacing: 4.0,
            actions: [
              TextButton(
                  onPressed: (){
                    SocialLayoutCubit.get(context)
                        .updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text
                    );
                  },
                  child:Text(
                'UPDATE',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16
                ),
              ) ),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if(state is SocialLoadingStates)
                    LinearProgressIndicator(),
                  Container(
                    height: 180.0,
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children:[
                          //Align لتحريك العنصر ممن مكانه
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children:[
                                  Container(
                                  height: 150.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight:Radius.circular(20.0),
                                    ),
                                    image: DecorationImage(
                                      image:coverImage==null? NetworkImage(
                                        "${userModel.cover}",
                                      ):FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        child: IconButton(onPressed: (){
                                          SocialLayoutCubit.get(context).getcoverImage();
                                        },
                                            icon: Icon(Icons.camera_alt_outlined))
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: profileImage == null ?NetworkImage(
                                  "${userModel.image}",
                                ):FileImage(profileImage),
                              ),
                            ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: IconButton(
                                    onPressed: (){
                                      SocialLayoutCubit.get(context).getProfileImage();
                                    },
                                    icon: Icon(Icons.camera_alt_outlined))
                              ),

                            ],
                          ),
                        ]
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(SocialLayoutCubit.get(context).profileImage!=null||SocialLayoutCubit.get(context).coverImage!=null)
                    Row(
                    children:[
                      Expanded(
                        child: Column(
                          children: [
                            if(SocialLayoutCubit.get(context).coverImage!=null)
                              defaultButton(onPressed: (){
                              SocialLayoutCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                              );
                            }, text: 'upload cover'),
                            if(state is SocialLoadingStates)
                              SizedBox(
                                height: 5.0,
                              ),
                            if(state is SocialLoadingStates)
                              LinearProgressIndicator(),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            if(SocialLayoutCubit.get(context).profileImage!=null)
                              defaultButton(
                                  onPressed: ()
                                  {
                              SocialLayoutCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                              );
                            }, text: 'upload profile'),
                            if(state is SocialLoadingStates)
                              SizedBox(
                               height: 5.0,
                             ),
                            if(state is SocialLoadingStates)
                              LinearProgressIndicator(),

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Form(child: Column(
                    children: [

                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          labelText: 'name',
                          hintText: 'name',
                          prefix:Icons.people_alt,
                          validate:(String value){
                            if(value.isEmpty){
                              return  'type your name' ;
                            }
                          }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      defaultFormField(
                          controller: bioController,
                          labelText: 'bio...',
                          type: TextInputType.text,
                          hintText: 'bio',
                          prefix:Icons.edit,
                          validate:(String value){
                            if(value.isEmpty){
                              return  'type your bio' ;
                            }
                          }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      defaultFormField(
                          controller: phoneController,
                          type:TextInputType.phone,
                          hintText: 'phone',
                          labelText: 'phone',
                          prefix:Icons.phone,
                          validate:(String value) {
                            if (value.isEmpty) {
                              return 'type your phone';
                            }
                          },

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialLogin()));
                      }, text: "صفحه تسجيل الدخول"),


                      SizedBox(
                        height:15.0,
                      ),
                      defaultButton(onPressed: (){
                        FirebaseAuth.instance.currentUser.sendEmailVerification();
                      }, text: "اشعار للايميل ممكن تلقاه فى ال spam"),
                      //
                      // defaultButton(onPressed: (){
                      //   FirebaseMessaging.instance.subscribeToTopic('sub');
                      // }, text: "اشتراك"),
                      // defaultButton(onPressed: (){
                      //   FirebaseMessaging.instance.unsubscribeFromTopic('unSub');
                      //   print('un');
                      // }, text: " الغاء اشتراك")


                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
