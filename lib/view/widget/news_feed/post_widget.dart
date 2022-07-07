import 'package:flutter/material.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/model/post_mode.dart';
import 'package:social_test/view/screen/comment/comment_screen.dart';


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
                        "0",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {

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
                          "0 Comment",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
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
              InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
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
                                IconBroken.Message,
                                size: 25.0,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ]),
    ),
  );
}

