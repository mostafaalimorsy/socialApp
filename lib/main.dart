import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/cubit.dart';
import 'package:social_test/controller/cubit/auth/rigester/cubit.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/bloc_observe.dart';
import 'package:social_test/controller/service/cash_helper.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/theme.dart';
import 'package:social_test/firebase_options.dart';
import 'package:social_test/view/screen/main_screen.dart';
import 'view/screen/Auth/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CachHelper.init();
  Widget widget;
  uId = CachHelper.getData(key: 'uId');

  bool? isDarkModeEnabled = CachHelper.getData(key: 'isDark');
  if (uId != null) {
    widget = const MainScreen();
  } else {
    widget = const LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget? widget;
   bool? isDarkModeEnabled;

  MyApp({
    Key? key,
    this.widget,
    this.isDarkModeEnabled,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(create: (context) => SocialRigesterCubit()),
        BlocProvider(
            create: (context) => SocialAppCubit()
              ..getUserData()
              ..getPosts()
              ..getComments()..changeAppMode()),
      ],
      child: BlocConsumer<SocialAppCubit , SocialAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social APP',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialAppCubit.get(context).isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
