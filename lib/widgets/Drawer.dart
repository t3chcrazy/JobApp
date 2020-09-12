import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('ITJobs menu'),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () => Navigator.of(context).pushNamed("/profile"),
          ),
          ListTile(
            title: Text('Saved Jobs'),
            onTap: () => Navigator.of(context).pushNamed("/saved"),
          ),
          ListTile(
            title: Text("Applied Jobs"),
            onTap: () => Navigator.of(context).pushNamed("/applied")
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () => BlocProvider.of<LoginBloc>(context).add(LogoutInitiate()),
          ),
          ListTile(
            title: Text("Conversations"),
            onTap: () => Navigator.of(context).pushNamed("/chat"),
          )
        ],
      ),
    );
  }
}