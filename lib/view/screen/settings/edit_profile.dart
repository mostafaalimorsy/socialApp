import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/view/widget/custom_widget/custom_auth_button.dart';
import 'package:social_test/view/widget/custom_widget/custom_textformfield_widget.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);
        var userModer = getData.model;
        namecontroller.text = userModer!.name!;
        emailcontroller.text = userModer.email!;
        phonecontroller.text = userModer.phone!;
        biocontroller.text = userModer.bio!;
        var profileImageFile = SocialAppCubit.get(context).profileImageFile;
        var coverImageFile = SocialAppCubit.get(context).coverImageFile;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: Text("Edit Profile"),
            actions: [
              TextButton(
                onPressed: () {
                  getData.updateUser(
                      name: namecontroller.text,
                      phone: phonecontroller.text,
                      bio: biocontroller.text,
                      email: emailcontroller.text);




                },
                child: Text("Update"),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if(state is SocialUpdateUserloadingStates) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      height: 190,
                      width: double.infinity,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(4.0),
                                          topLeft: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(
                                            image: coverImageFile == null
                                                ? NetworkImage(
                                                    '${userModer.cover}',
                                                  )
                                                : FileImage(coverImageFile)
                                                    as ImageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                  CircleAvatar(
                                      radius: 16,
                                      child: IconButton(
                                          onPressed: () {
                                            getData.getCoverImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Camera,
                                            size: 16,
                                          ))),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImageFile == null
                                        ? NetworkImage('${userModer.image}')
                                        : FileImage(profileImageFile)
                                            as ImageProvider,
                                  ),
                                  CircleAvatar(
                                      radius: 16,
                                      child: IconButton(
                                          onPressed: () {
                                            getData.getProfileImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Camera,
                                            size: 16,
                                          )))
                                ],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(getData.profileImage !=null ||getData.coverImage !=null )
                    Row(
                      children: [
                        if(getData.profileImage !=null)
                        Expanded(child: Column(
                          children: [
                            authButton(context: context,authButtonText: 'Upload profile ',onpressed: (){
                              getData.uploadProfileImage(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                bio: biocontroller.text,
                                email: emailcontroller.text,
                              );
                            }),
                            SizedBox(height: 5,),
                            if (state is SocialUserImagesUpdateloadingStates)
                            LinearProgressIndicator(),
                          ],
                        )),
                        SizedBox(width: 5.0,),
                        if(getData.coverImage !=null)
                        Expanded(child: Column(
                          children: [
                            authButton(context: context,authButtonText: 'Upload Cover ',onpressed: (){
                              getData.uplodCoverImage(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                bio: biocontroller.text,
                                email: emailcontroller.text,
                              );

                            }),
                            SizedBox(height: 5,),
                            if (state is SocialUserImagesUpdateloadingStates)
                            LinearProgressIndicator(),
                          ],
                        )),
                      ],
                    ),
                    if(getData.profileImage !=null ||getData.coverImage !=null ) SizedBox(
                      height: 20,
                    ),

                    defaultTextForm(
                        labelText: "Name",
                        hintText: "Ahmed Hassan",
                        type: TextInputType.name,
                        icon: IconBroken.User,
                        msg: "Check Name again",
                        controller: namecontroller),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextForm(
                        labelText: "BIO",
                        hintText: "Write Your BIO",
                        type: TextInputType.text,
                        icon: IconBroken.Info_Circle,
                        controller: biocontroller),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextForm(
                        labelText: "Cellphone",
                        hintText: "01xxxxxxx",
                        type: TextInputType.name,
                        icon: IconBroken.Calling,
                        msg: 'Enter your phone',
                        controller: phonecontroller),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextForm(
                        labelText: "email",
                        hintText: "text@gmail.com",
                        type: TextInputType.name,
                        icon: IconBroken.Message,
                        msg: 'Enter your email',
                        controller: emailcontroller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
