import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/AppliedJob.dart';
import '../bloc/jobs/jobs_bloc.dart';
import '../models/Job.dart';

class AppliedScreen extends StatelessWidget {

  static const routeName = "/applied";

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700);
    final centerText = TextStyle(color: Colors.grey, fontSize: 18);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top+16, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 10),
                Text("Applied jobs", style: title)
              ],
            ),
            Expanded(
              child: BlocBuilder<JobsBloc, JobsState>(
                builder: (context, state) {
                  final List<Job> appliedList = state.jobs.where((element) => element.jobIsApplied).toList();
                  if (appliedList.length == 0) {
                    return Center(
                      child: Text("No applied jobs yet!", style: centerText),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => AppliedJobCard(appliedJob: appliedList[index],), 
                    separatorBuilder: (context, index) => SizedBox(height: 5), 
                    itemCount: appliedList.length
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}