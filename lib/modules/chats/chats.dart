import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/component.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/models/create_users.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';

class Chats extends StatelessWidget {
  const Chats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        builder: (context,state){
          return ConditionalBuilder(
              condition: SocialLayoutCubit.get(context).users.length>0,
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,index)=>itemChatBuilder(SocialLayoutCubit.get(context).users[index],context),
                  separatorBuilder: (context,index)=>myDivider(),
                  itemCount: SocialLayoutCubit.get(context).users.length,
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context,state){},
    );
  }

  Widget itemChatBuilder(SocialCreateUserModel model,context)=> InkWell(
    onTap:(){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.4,
                fontSize: 15,

              ),
            ),
          ),
        ],
      ),
    ),
  );
}
