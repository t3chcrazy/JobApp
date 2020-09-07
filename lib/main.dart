import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/ProfileScreen.dart';
import 'screens/JobDescScreen.dart';
import 'models/Job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login/login_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootApp();
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: "Roboto",
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == LoginScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => LoginScreen(),
            );
          }
          else if (settings.name == HomeScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
          }
          else if (settings.name == JobDescScreen.routeName) {
            final Job jobArg = settings.arguments as Job;
            return MaterialPageRoute(
              builder: (context) => JobDescScreen(job: jobArg,),
            );
          }
          else if (settings.name == ProfileScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}