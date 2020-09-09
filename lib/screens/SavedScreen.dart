import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jobs/jobs_bloc.dart';
import '../widgets/SavedJob.dart';
import '../models/Job.dart';

class SavedScreen extends StatelessWidget {

  static const routeName = "/saved";

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700);
    final centerText = TextStyle(color: Colors.grey, fontSize: 18);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top+16, 16, 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 10),
                Text("Saved jobs", style: title)
              ],
            ),
            Expanded(
              child: BlocBuilder<JobsBloc, JobsState>(
                builder: (context, state) {
                  final List<Job> savedList = state.jobs.where((element) => element.jobIsSaved).toList();
                  if (savedList.length == 0) {
                    return Center(
                      child: Text("No saved jobs yet!", style: centerText),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => SavedJobCard(savedJob: savedList[index],), 
                    separatorBuilder: (_, __) => SizedBox(height: 5), 
                    itemCount: savedList.length
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}