



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/modules/post/post.dart';

class Feeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener:(context,state){},
      builder:(context,state){
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            ConditionalBuilder(
              condition: SocialLayoutCubit.get(context).posts.length>0&&SocialLayoutCubit.get(context).usermodel!=null,
              builder: (context)=>Scaffold(
                body: SingleChildScrollView(
                  physics:  BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin:  EdgeInsets.all(
                          8.0,
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                             Image(
                              image: NetworkImage(
                                'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme.of(context).textTheme.subtitle1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(SocialLayoutCubit.get(context).posts[index],context,index),
                        separatorBuilder: (context, index) =>  SizedBox(
                          height: 8.0,
                        ),
                        itemCount: SocialLayoutCubit.get(context).posts.length,
                      ),
                       SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),

              ),
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            Positioned(
              right: 30,
              bottom:20 ,
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Post()));
                },
                child:  Icon(Icons.add_box_rounded,
                  color: Colors.white,

                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                backgroundColor:  HexColor('#BE10C1A'),
                elevation: 1.0,

              ),
            ),

          ],
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin:  EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
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
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon:  Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding:  EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding:  EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style:
          //                 Theme.of(context).textTheme.caption.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding:  EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style:
          //                 Theme.of(context).textTheme.caption.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage!='')
            Container(
            height: 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                4.0,
              ),
              image:DecorationImage(
                image: NetworkImage(
                  '${model.postImage}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                           Icon(
                            Icons.heart_broken,
                            size: 16.0,
                            color: Colors.red,
                          ),
                           SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialLayoutCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           Icon(
                            Icons.chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                           SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialLayoutCubit.get(context).comments[index]} comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                       CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialLayoutCubit.get(context).usermodel.image}',
                        ),
                      ),
                       SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style:
                        Theme.of(context).textTheme.caption.copyWith(),
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialLayoutCubit.get(context).postComments(SocialLayoutCubit.get(context).postsId[index]);
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                     Icon(
                      Icons.heart_broken,
                      size: 16.0,
                      color: Colors.red,
                    ),
                     SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: () {
                  SocialLayoutCubit.get(context).postsLike(SocialLayoutCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}