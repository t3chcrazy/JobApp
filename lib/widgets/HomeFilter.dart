import 'package:flutter/material.dart';
import '../models/Job.dart' show JobType;

enum SearchTitle {JobName, CompanyName, SkillName}

class HomeFilter extends StatefulWidget {

  final SearchTitle activeTitle;
  final JobType activeType;
  final Function handleSelectedFilter;
  final Function handleJobType;
  final Function handleTag;

  HomeFilter({
    @required this.activeTitle,
    @required this.activeType,
    @required this.handleSelectedFilter, 
    @required this.handleJobType,
    @required this.handleTag
  });

  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {

  BoxDecoration mapTitleToDecoration(SearchTitle title) {
    if (title == widget.activeTitle) {
      return BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      );
    }
    else {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.5, color: Colors.green)
      );
    }
  }

  BoxDecoration mapTypeToDecoration(JobType type) {
    if (type == widget.activeType) {
      return BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      );
    }
    else {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.5, color: Colors.green)
      );
    }
  }

  String mapTitleToText(SearchTitle title) {
    switch (title) {
      case SearchTitle.JobName:
        return "Job Name";
      case SearchTitle.CompanyName:
        return "Company Name";
      default:
        return "Skill Name";
    }
  }

  String mapTypeToText(JobType type) {
    switch (type) {
      case JobType.Fulltime:
        return "Full Time";
      case JobType.PartTime:
        return "Part Time";
      case JobType.Contract:
        return "Contract";
      default:
        return "Internship";
    }
  }

  @override
  Widget build(BuildContext context) {
    final sectionTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top, 16, MediaQuery.of(context).viewInsets.bottom+30),
      child: Container(
        height: MediaQuery.of(context).size.height*0.4,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Search by", style: sectionTitle),
                SizedBox(height: 10),
                Row(
                  children: SearchTitle.values.map((e) => GestureDetector(
                  onTap: () => widget.handleSelectedFilter(e),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: mapTitleToDecoration(e),
                    child: Text(mapTitleToText(e)),
                  ),
                )).toList(),
                )
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Show only", style: sectionTitle),
                SizedBox(height: 10),
                FittedBox(
                  child: Row(
                    children: JobType.values.map((e) => GestureDetector(
                    onTap: () => widget.handleJobType(e),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: mapTypeToDecoration(e),
                      child: Text(mapTypeToText(e))
                    )
                  )).toList(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}