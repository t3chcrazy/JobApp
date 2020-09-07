import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:itjobs/bloc/login/login_bloc.dart';
import '../utils/CheckFlare.dart';
import '../utils/LoginClipper.dart';
import '../widgets/LoginInput.dart';
import '../constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  
  TextEditingController _email;
  TextEditingController _password;

  AnimationController _animationController;
  Animation _animationValue;

  AnimationController _successController;
  Animation _successValue;
  bool isPaused = true;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
    _animationValue = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic
      )
    );
    _animationController.forward();
    _successController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2, microseconds: 500)
    );
    _successController.addListener(() {
      if (_successController.value == 1.0) {
        print("success value is one now");
        BlocProvider.of<LoginBloc>(context).add(LoginInitiate("suman4283@gmail.com", "helloworld"));
      }
    });
    _successValue = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: Curves.easeInOutCubic,
      )
    );
  }

  void _handleSignin() {
    print("I am called");
    if (formKey.currentState.validate()) {
      _animationController.reverse();
      _successController.forward();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoggedIn) {
            Navigator.of(context).pushNamed("/home");
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _successController,
              builder: (context, child) => Positioned(
                width: dimensions.width,
                height: dimensions.height,
                child: Opacity(
                  opacity: _successValue.value,
                  child: child,
                ),
              ),
              child: Container(
                width: dimensions.width/2,
                height: dimensions.height/2,
                alignment: Alignment.center,
                child: FlareActor(
                  "$flareDir/success.flr",
                  controller: CustomFlare(),
                ),
              )
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Positioned(
                width: dimensions.width,
                top: (_animationValue.value-1)*dimensions.height*0.3,
                height: dimensions.height*0.3,
                child: Opacity(
                  opacity: _animationValue.value,
                  child: ClipPath(
                    clipper: CustomCurve(),
                    child: Container(
                      height: dimensions.height*0.3,
                      alignment: Alignment.bottomCenter,
                      color: Colors.green,
                      child: child
                    ),
                  ),
                )
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: dimensions.height*0.1),
                child: SvgPicture.asset("$imgDir/logo.svg", width: dimensions.height*0.14, height: dimensions.height*0.14)
              )
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Positioned(
                width: dimensions.width,
                height: 0.65*dimensions.height,
                top: (1-0.74*_animationValue.value)*dimensions.height,
                child: Opacity(
                  opacity: _animationValue.value,
                  child: Container(
                    child: child
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                      SizedBox(height: 10),
                      LoginInput(controller: _email,),
                      SizedBox(height: 10),
                      LoginInput(controller: _password, isPassword: true,),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: _handleSignin,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [Colors.green.withOpacity(0.7), Colors.green]
                            ),
                            boxShadow: [BoxShadow(
                              color: const Color(0x1a000000),
                              offset: Offset(0,3),
                              blurRadius: 10,
                              spreadRadius: 0
                            )]
                          ),
                          child: Text("Sign in", style: TextStyle(color: Colors.white))
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}