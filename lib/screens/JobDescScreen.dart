import 'package:flutter/material.dart';
import 'package:itjobs/widgets/SkillTag.dart';
import '../models/Job.dart';
import '../widgets/Overview.dart';
import '../widgets/Responsibilities.dart';
import '../widgets/LocationPage.dart';

class JobDescScreen extends StatefulWidget {

  static const routeName = "/jobdesc";


  final Job job;

  JobDescScreen({this.job});


  @override
  _JobDescScreenState createState() => _JobDescScreenState();
}

class _JobDescScreenState extends State<JobDescScreen> {

  final double borderRadius = 30.0;
  final double topFactor = 0.35;
  final List<String> sectionTitles = [
    "Overview",
    "Responsibilities",
    "Location"
  ];
  int tabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final dimensions = MediaQuery.of(context).size;
    final currJob = widget.job;
    final location = currJob.jobCompany.companyLocation;

    //TODO: Test job description screen
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: dimensions.width,
                height: topFactor*dimensions.height,
                padding: const EdgeInsets.all(16),
                color: Color(0xFFf1f2f6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(height: 10),
                    Text(currJob.jobTitle, style: TextStyle(fontSize: 25)),
                    SizedBox(height: 5),
                    Text(currJob.jobCompany.companyName, style: TextStyle(fontSize: 20, color: Colors.grey[500])),
                    SizedBox(height: 5),
                    Text(currJob.jobSalary.toString(), style: TextStyle(color: Colors.green)),
                    SizedBox(height: 5),
                    Text("${location.city}, ${location.state}"),
                    SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Skills required:"),
                        SizedBox(width: 5),
                        ...currJob.jobTags.map((tag) => SkillTag(skillTag: tag,)).toList()
                      ],
                    )
                  ],
                )
              ),
            ),
            Positioned(
              top: topFactor*dimensions.height,
              child: Transform(
                transform: Matrix4.translationValues(0, -borderRadius, 0),
                child: Container(
                  width: dimensions.width,
                  height: dimensions.height*(1-topFactor)+borderRadius,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    boxShadow: [BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0,0),
                      blurRadius: 6,
                      spreadRadius: 0
                    )]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: sectionTitles.map((e) => Expanded(
                          child: GestureDetector(
                            onTap: () => _pageController.animateToPage(sectionTitles.indexOf(e), duration: Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn),
                            child: Text(e, textAlign: TextAlign.center, style: TextStyle(color: tabIndex == sectionTitles.indexOf(e)? Colors.green: Colors.green[200])),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (value) => setState(() {
                            tabIndex = value;
                          }),
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Overview(),
                            Responsibilities(),
                            LocationPage()
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text("Apply to this job!"),
                        onPressed: () {},
                        color: Colors.green,

                      ),
                      SizedBox(height: 10),
                    ],
                  )
                )
              ),
            )
          ],
        )
      )
    );
  }
}