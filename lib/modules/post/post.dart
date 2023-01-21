import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';

class Post extends StatelessWidget {

  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            elevation: 0.0,
            backgroundColor:  HexColor('#BE5C1A'),
            title: Text("Create Post"),
            actions: [
              TextButton(onPressed: (){
                var now=DateTime.now();
                if(SocialLayoutCubit.get(context).postImage ==null)
                  {
                  SocialLayoutCubit.get(context)
                      .createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                  );
                  }else{

                  SocialLayoutCubit.get(context)
                      .uploadPostImage(
                    dateTime: now.toString(),
                    text: textController.text,
                  );
                }
              }, child: Text(
                'POST',
                style: TextStyle(
                    color: Colors.white
                ),
              ),),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.only(
                top: 22.0,
                right: 8.0,
                left: 12.0,
                bottom: 18.0
            ),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingImage)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingImage)
                  SizedBox(
                    height: 15.0,
                  ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Mahmoud Moamen',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),

                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      hintText: 'what is on your mind....?'
                    ),
                  ),
                ),
                if(SocialLayoutCubit.get(context).postImage !=null)
                  Stack(
                    alignment: Alignment.topRight,
                    children:[
                      Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              image:FileImage(SocialLayoutCubit.get(context).postImage)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: IconButton(onPressed: (){
                              SocialLayoutCubit.get(context).removePostImage();
                            },
                                icon: Icon(Icons.close))
                        ),
                      ),

                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialLayoutCubit.get(context)
                                .getPostImage();
                          }, child:
                      Row(
                        children:[
                          Icon(Icons.image),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('add photo',)
                        ]
                      )),
                    ),

                    Expanded(
                      child: TextButton(onPressed: (){}, child:
                      Text('# tage',),),
                    ),
                  ],
                ),

              ],
            ),
          ) ,

        );
      },
    );
  }
}
