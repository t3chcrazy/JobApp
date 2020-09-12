import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/ProfileScreen.dart';
import 'screens/JobDescScreen.dart';
import 'screens/SavedScreen.dart';
import 'screens/AppliedScreen.dart';
import 'screens/ChatScreen.dart';
import 'models/Job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/previous/previous_bloc.dart';
import 'bloc/skills/skills_bloc.dart';
import 'bloc/jobs/jobs_bloc.dart';
import 'bloc/projects/projects_bloc.dart';

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
        ),
        BlocProvider(
          create: (context) => SkillsBloc(),
        ),
        BlocProvider(
          create: (context) => PreviousBloc(),
        ),
        BlocProvider(
          create: (context) => JobsBloc(),
        ),
        BlocProvider(
          create: (context) => ProjectsBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Roboto",
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
          else if (settings.name == AppliedScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => AppliedScreen(),
            );
          }
          else if (settings.name == SavedScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => SavedScreen(),
            );
          }
          else if (settings.name == ChatScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => ChatScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}