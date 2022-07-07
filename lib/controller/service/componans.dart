import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_test/controller/service/icon_broken.dart';


  void navigatTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget),
  );

void navigatReplace (context , widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => widget), (route) => false);


void msgAlarm( { msg,ToastStates? states,Color? textColor})
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: chosseToastColor(states!),
      textColor: textColor,
      fontSize: 16.0
  );



}
enum ToastStates {SUCCESS,ERROR,WARNING}
Color chosseToastColor (ToastStates states)
{
  Color color;
  switch(states)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;

    case ToastStates.ERROR:
      color= Colors.red;
      break;

    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}



Widget defaltAppBar({required BuildContext context , Widget? title ,  List<Widget>?actions}){
  return AppBar(
    leading: IconButton(onPressed: (){
      Navigator.pop(context);
    },icon: Icon(IconBroken.Arrow___Left_2) ,),
    title: title,
    actions: actions,
  );
}