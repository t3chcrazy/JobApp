import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/previous/previous_bloc.dart';
import '../bloc/projects/projects_bloc.dart';
import '../bloc/skills/skills_bloc.dart';
import '../widgets/ProfileSection.dart';
import '../widgets/ProfileTab.dart';
import '../widgets/ProfileSectionTitle.dart';
import '../widgets/SocialLink.dart';
import '../models/User.dart';
import '../utils/ProfileClipper.dart';
import '../utils/JobList.dart';
import '../constants/constants.dart';

class ProfileScreen extends StatelessWidget {

  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final User user = User(
      name: "John Doe", 
      currentJob: jobList[jobList.length-1], 
      status: Status.NoticePeriod, 
      jobHistory: userPreviousJobs, 
      socialLinks: socialLinks,
      tags: [...tagCombinations[1], ...tagCombinations[2]]
    );
    final dimensions = MediaQuery.of(context).size;
    final sectionTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ProfileClipper(),
              child: Container(
                width: dimensions.width,
                height: dimensions.height*0.4,
                alignment: Alignment.center,
                color: Colors.green,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(user.name, style: sectionTitle),
                    Text(user.currentJob.jobTitle, style: TextStyle(color: Colors.grey[100])),
                    SizedBox(height: 20),
                    SvgPicture.asset("$imgDir/man.svg", width: 100, height: 100),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensions.height*0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ProfileTab(icon: Icons.person, metric: "Connections", value: 230,),
                      ProfileTab(icon: Icons.remove_red_eye, metric: "Profile Views", value: 101),
                      ProfileTab(icon: Icons.supervised_user_circle, metric: "Contacted", value: 30)
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<SkillsBloc, SkillsState>(
                    builder: (context, state) => ProfileSection(
                      title: "Skills",
                      sectionItems: state.skillTags,
                    ),
                  ),
                  BlocBuilder<PreviousBloc, PreviousState>(
                    builder: (context, state) => ProfileSection(
                      title: "Previous Jobs",
                      sectionItems: state.prevJobs,
                    ),
                  ),
                  BlocBuilder<ProjectsBloc, ProjectsState>(
                    builder: (context, state) => ProfileSection(
                      title: "Projects",
                      sectionItems: state.projects,
                    ),
                  ),
                  ProfileSectionTitle(title: "Social Links"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: user.socialLinks.map((social) => SocialLink(socialLink: social,)).toList(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}