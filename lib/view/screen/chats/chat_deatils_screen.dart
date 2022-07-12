import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/model/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? model;

  ChatDetailsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <SocialAppCubit , SocialAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData= SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2), onPressed: () { Navigator.pop(context); },),
            titleSpacing: 0,
            title: Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model!.image}',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "${model!.name}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
          ),
          body: Text("HBKHKHD"),
        );
      },
    );
  }
}
