import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/models/create_users.dart';

import '../../models/message_chat.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialCreateUserModel userModel;

  ChatDetailsScreen({
    this.userModel,
  });


  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //بيتعمل علشان انفذ حاجه قبل ال consumer
    return Builder(
      builder: (BuildContext context) {
        SocialLayoutCubit.get(context).getMessage(
            receiver: userModel.uid,

        );

        return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor:  HexColor('#BE5C1A'),

                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        userModel.name,
                      ),
                    ),
                    SizedBox(
                      width:20.0,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) =>
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {

                                var message=SocialLayoutCubit.get(context).messages[index];

                                if(SocialLayoutCubit.get(context).usermodel.uid == message.sender)
                                  {
                                    return Column(
                                      children: [
                                        buildMyMessage(message,context),
                                        if(SocialLayoutCubit.get(context).chatImage !=null)
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children:[
                                              Container(
                                                height: 300.0,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  image: DecorationImage(
                                                      image:FileImage(SocialLayoutCubit.get(context).chatImage),
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
                                                      SocialLayoutCubit.get(context).removeChatImage();
                                                    },
                                                        icon: Icon(Icons.close))
                                                ),
                                              ),

                                            ],
                                          ),
                                      ],
                                    ) ;
                                  }

                                return buildMessage(message,context);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15.0,
                              ),
                              itemCount: SocialLayoutCubit.get(context).messages.length,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: TextFormField(
                                      controller: messageController,

                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ...',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                IconButton(
                                    onPressed: (){
                                      SocialLayoutCubit.get(context).getChatImage();
                                    },
                                    icon: Icon(Icons.camera_alt)),
            SizedBox(
            width: 5.0,
            ),
                                Container(
                                  height: 50.0,
                                  color: HexColor('#BE5C1A'),
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialLayoutCubit.get(context).sendMessage(
                                        receiver: userModel.uid,
                                        dateTime:DateTime.now().toString(),
                                        text: messageController.text,


                                      );
                                      messageController.text="";

                                    },
                                    minWidth: 1.0,
                                    child: Icon(
                                      Icons.send,
                                      size: 16.0,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                fallback: (context) =>
                    Center(
                      child: CircularProgressIndicator(),
                    ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model,context) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        model.text,
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model,context) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(
          .2,
        ),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Text(
            model.text,
          ),


        ],
      ),
    ),
  );
}
