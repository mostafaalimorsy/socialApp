import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/cubit.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/states.dart';
import 'package:social_test/controller/service/cash_helper.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/view/screen/Auth/login/rigester_screen.dart';
import 'package:social_test/view/screen/main_screen.dart';
import 'package:social_test/view/widget/custom_widget/custom_auth_button.dart';
import 'package:social_test/view/widget/custom_widget/custom_text_buton.dart';
import 'package:social_test/view/widget/custom_widget/custom_textformfield_widget.dart';


Widget loginWidget(context, VoidCallback? onpressed) {
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwdcontroller = TextEditingController();
  return BlocConsumer<SocialLoginCubit, SocialAppLoginStates>(
    listener: (BuildContext context, state) {
      if (state is SocialAppScuccessStates) {
        msgAlarm(
          msg: "the Login operation is success",
          states: ToastStates.SUCCESS,
          textColor: Colors.white,
        );
        CachHelper.saveData(key: 'uId', value: state.Uid).then((value) {
          navigatReplace(context, const MainScreen());
        });

      }
    },
    builder: (BuildContext context, SocialAppLoginStates state) {
      SocialLoginCubit getData = SocialLoginCubit.get(context);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(
                      color: Colors.black
                  ),
                ),
                Text(
                  "Login now to Chat with your friend",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                //Auth
                defaultTextForm(
                    msg: 'please enter your e-mail',
                    type: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "text@email.com",
                    controller: emailcontroller,
                    icon: Icons.email_outlined
                ),

                const SizedBox(
                  height: 15,
                ),
                //password
                defaultTextForm(
                    msg: 'please enter your password',
                    type: TextInputType.visiblePassword,
                    labelText: "password",
                    hintText: "******",
                    controller: passwdcontroller,
                    icon: Icons.lock_outline,
                    passwd: getData.password,
                    visableIcon: getData.suffix,
                    onTap: () {
                      getData.changPasswordVisiability();
                    }

                ),

                const SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  condition: state is! SocialAppLoadingStates,
                  builder: (BuildContext context) {
                    return authButton(
                        context: context,
                        authButtonText: "Login",
                        onpressed: () {
                          if (formkey.currentState!.validate()) {
                            getData.GetLogin(email: emailcontroller.text,
                                password: passwdcontroller.text);
                            // print(emailcontroller.text);
                            // print(passwdcontroller.text);
                          }
                        }
                    );
                  }, fallback: (BuildContext context)=>  const Center(child: CircularProgressIndicator()),


                ),
                const SizedBox(
                  height: 15,
                ),
                //Rigester button
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      CustomTextButton(context: context,
                          route: const RigesterScreen(),
                          text: "RIGESTER"),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    },

  );
}
