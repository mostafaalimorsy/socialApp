import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/cubit.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/states.dart';
import 'package:social_test/view/widget/Auth/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialLoginCubit(),
    child: BlocConsumer <SocialLoginCubit , SocialAppLoginStates>(
    listener: (BuildContext context, state) {  },
    builder: (BuildContext context, SocialAppLoginStates state) {
      return Scaffold(body: Center(child: SingleChildScrollView(child: loginWidget(context, (){}))));
    }, ));
  }
}
