import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/model/post_mode.dart';
import 'package:social_test/view/screen/comment/comment_screen.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);
        return ConditionalBuilder(
          condition:  getData.posts.isNotEmpty && getData.model != null  ,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (FirebaseAuth.instance.currentUser!.emailVerified ||
                      getData.model!.isEmailVerified != true)
                    Container(
                      color: Colors.amber.withOpacity(.6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.warning),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text("please verify your email"),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  msgAlarm(
                                      msg: "Check your email",
                                      states: ToastStates.SUCCESS);
                                });
                                getData.model!.isEmailVerified = true;
                              },
                              child: const Text('send email verification'),
                            )
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image.network(
                              'https://img.freepik.com/free-photo/aerial-view-business-team_53876-124515.jpg?t=st=1656880893~exp=1656881493~hmac=2e9749b5f03fd7e500be9b8910e585445094776576e1a3508e5b9ba8b09e2dbe&w=826',
                              fit: BoxFit.cover,
                              height: 150.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Communicate with your friends",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // posts
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(getData.posts[index], context, index),
                    itemCount: getData.posts.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 8.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem( PostModel postModel,context, index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${postModel.image}',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${postModel.name}",
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 16.0,
                          color: defaultColor,
                        )
                      ],
                    ),
                    Text(
                      "${postModel.dateTime}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(IconBroken.More_Circle)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          //to show body of post
          Text(
            "${postModel.text} ",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black),
          ),
          //to show hashtag
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10, top: 5),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(right: 5),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //                 minWidth: 10.0,
          //                 height: 25.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: Text(
          //                   "#software",
          //                   style: TextStyle(color: defaultColor),
          //                 )),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 5),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //                 minWidth: 10.0,
          //                 height: 25.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: Text(
          //                   "#software",
          //                   style: TextStyle(color: defaultColor),
          //                 )),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 5),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //                 minWidth: 10.0,
          //                 height: 25.0,
          //                 padding: EdgeInsets.zero,
          //                 onPressed: () {},
          //                 child: Text(
          //                   "#software",
          //                   style: TextStyle(color: defaultColor),
          //                 )),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          //img of post
          if(postModel.postImage != '')
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image: NetworkImage(
                        '${postModel.postImage}',
                      ),
                      fit: BoxFit.cover)),
            ),
          //like , comment and number icons
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                //likes
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${SocialAppCubit.get(context).likes[index]}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {

                      SocialAppCubit.get(context).likePost( SocialAppCubit.get(context).postsId[index]);

                    },
                  ),
                ),
                //comment
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 20.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${SocialAppCubit.get(context).comments[index]} Comment",
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      navigatTo(context, CommentScreen(SocialAppCubit.get(context).postsId[index]));
                      print(SocialAppCubit.get(context).commentsModel[index] .postId);
                      print(SocialAppCubit.get(context).postsId[index]);

                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          //write a comment
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    '${postModel.image}',
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "write a comment ...",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 25.0,
                            color: Colors.red,
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
        ]),
      ),
    );
  }

}
