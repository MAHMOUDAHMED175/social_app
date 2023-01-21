import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';

class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180.0,
                child: Stack(
                    alignment: Alignment.bottomCenter,
                    children:[
                      //Align لتحريك العنصر ممن مكانه
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight:Radius.circular(20.0),
                            ),

                            image: DecorationImage(
                              image:SocialLayoutCubit.get(context).usermodel.cover==null? NetworkImage(
                                SocialLayoutCubit.get(context).usermodel.cover,
                              ):NetworkImage(
                                '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            "${SocialLayoutCubit.get(context).usermodel.image}",                          ),
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${SocialLayoutCubit.get(context).usermodel.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${SocialLayoutCubit.get(context).usermodel.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '265',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                        style: TextStyle(
                            color: HexColor('#BE5C1A')
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>EditProfile(),
                      )
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      size: 16.0,
                      color: HexColor('#BE5C1A'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ;
      },

    );
  }
}
