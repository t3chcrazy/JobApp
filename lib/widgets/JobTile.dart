import 'package:flutter/material.dart';
import 'SkillTag.dart';
import '../models/Job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jobs/jobs_bloc.dart';

class JobTile extends StatelessWidget {

  final Job job;

  JobTile({this.job});

  String mapJobTypeToString(JobType type) {
    switch (type) {
      case JobType.Contract:
        return "Contract work";
      case JobType.Fulltime:
        return "Full-time";
      case JobType.Internship:
        return "Internship";
      default:
        return "Part-time work";
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: Style the job tile
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/jobdesc", arguments: job),
      child: Ink(
        child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0,0),
            blurRadius: 6,
            spreadRadius: 0
          )]
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(job.jobTitle, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(mapJobTypeToString(job.jobType), style: TextStyle(color: Colors.grey[700], fontSize: 12))
                        )
                      ],
                    ),
                    Text(job.jobCompany.companyName),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: job.jobTags.map((tag) => SkillTag(skillTag: tag,)).toList(),
                    ),
                    Text(job.jobCompany.companyLocation.city+", "+job.jobCompany.companyLocation.state, style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 12))
                  ],
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(
                        job.jobIsSaved? Icons.favorite: Icons.favorite_border, 
                        color: Colors.pink, size: 25
                      ),
                    onTap: () => BlocProvider.of<JobsBloc>(context).add(JobToggleSaved(job.jobTitle)),
                  ),
                  Text("Posted ${DateTime.now().difference(job.jobDatePosted).inDays.toString()} days ago", style: TextStyle(fontSize: 12))
                ],
              )
            )
          ],
        ),
      ),
      )
    );
  }
}