import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/view/screen/settings/edit_profile.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <SocialAppCubit , SocialAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData= SocialAppCubit.get(context);
        var userModer = getData.model;
        return Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                height: 190,
                width: double.infinity,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              topLeft: Radius.circular(4.0),
                            ),
                              image: DecorationImage(image: NetworkImage( '${userModer!.cover}',),fit: BoxFit.cover)
                          ),
                        ),
                      ),

                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${userModer.image}'
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 5,),
              Text("${userModer.name}",
                style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(height: 10,),
              Text("${userModer.bio}",
                style: Theme.of(context).textTheme.caption,),
              SizedBox(height: 20,),
              Row(children: [
                Expanded(
                  child: InkWell(
                    child: Column(children: [
                      Text("100",
                        style: Theme.of(context).textTheme.bodyText1,),
                      SizedBox(width: 10,),
                      Text("Post",
                        style: Theme.of(context).textTheme.caption,),
                    ],),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(children: [
                      Text("100k",
                        style: Theme.of(context).textTheme.bodyText1,),
                      SizedBox(width: 10,),
                      Text("Followers",
                        style: Theme.of(context).textTheme.caption,),
                    ],),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(children: [
                      Text("46K",
                        style: Theme.of(context).textTheme.bodyText1,),
                      SizedBox(width: 10,),
                      Text("Followings",
                        style: Theme.of(context).textTheme.caption,),
                    ],),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(children: [
                      Text("100",
                        style: Theme.of(context).textTheme.bodyText1,),
                      SizedBox(width: 10,),
                      Text("Photo",
                        style: Theme.of(context).textTheme.caption,),
                    ],),
                    onTap: (){},
                  ),
                ),

              ],),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () {  }, child: Text("Add Photos"),)),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    navigatTo(context, EditProfileScreen());
                  }, child: Icon(IconBroken.Edit_Square)),



                ],
              ),

            ],
          ),
        );
      },

    );
  }
}
