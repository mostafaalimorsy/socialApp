import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/model/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? model;

  ChatDetailsScreen({this.model});

  var msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialAppCubit.get(context).getMessages(reciverId: model!.uId!);
        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, SocialAppStates state) {
            SocialAppCubit getData = SocialAppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(IconBroken.Arrow___Left_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
              body: ConditionalBuilder(
                condition: true,
                fallback: (BuildContext context) =>
                    Center(child: CircularProgressIndicator()),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //the anther msg
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index) {
                                var msg = getData.message[index];
                                if (getData.model!.uId == msg.senderId) {
                                  return Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: defaultColor.withOpacity(0.2),
                                            borderRadius: BorderRadiusDirectional.only(
                                                bottomStart: Radius.circular(10),
                                                topEnd: Radius.circular(10),
                                                topStart: Radius.circular(10))),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        child: Text("${msg.text!}")),
                                  );
                                } else {
                                  return Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadiusDirectional.only(
                                                bottomEnd: Radius.circular(10),
                                                topEnd: Radius.circular(10),
                                                topStart: Radius.circular(10))),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        child: Text("${msg.text!}")),
                                  );
                                }
                              },
                              separatorBuilder:  (context,state) {
                               return SizedBox(height: 15,);
                              },
                              itemCount: getData.message.length),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: msgController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your massage here'),
                                ),
                              ),
                              Container(
                                height: 40,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    getData.sendMessage(
                                        reciverId: model!.uId!,
                                        text: msgController.text,
                                        dateTime: DateTime.now().toString());
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
