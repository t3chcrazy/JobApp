import 'package:flutter/material.dart';
import '../models/Job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jobs/jobs_bloc.dart';

class SavedJobCard extends StatelessWidget {

  final Job savedJob;

  SavedJobCard({@required this.savedJob});

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(fontSize: 20, color: Colors.grey);
    final companyName = TextStyle(fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: const Color(0x29000000),
          offset: Offset(0,0),
          blurRadius: 6,
          spreadRadius: 0
        )]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(savedJob.jobTitle, style: title),
                Text(savedJob.jobCompany.companyName, style: companyName)
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Icon(Icons.delete_forever),
                  onTap: () {
                    print("delete clicked");
                    BlocProvider.of<JobsBloc>(context).add(JobToggleSaved(savedJob.jobTitle));
                  }
                ),
                GestureDetector(
                  child: Text("Apply", style: TextStyle(color: Colors.green)),
                  onTap: () {
                    BlocProvider.of<JobsBloc>(context).add(JobToggleApplied(savedJob.jobTitle));
                    BlocProvider.of<JobsBloc>(context).add(JobToggleSaved(savedJob.jobTitle));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}