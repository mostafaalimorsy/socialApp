import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/cubit.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/states.dart';
import 'package:social_test/controller/cubit/auth/rigester/cubit.dart';
import 'package:social_test/controller/cubit/auth/rigester/states.dart';
import 'package:social_test/view/widget/Auth/register_widget.dart';

class RigesterScreen extends StatelessWidget {
  const RigesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialRigesterCubit(),
        child: BlocConsumer<SocialRigesterCubit, SocialAppRigesterStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, SocialAppRigesterStates state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Center(child: RigeterWidget(context)));
          },
        ));
  }
}
