import 'package:flutter/material.dart';
import 'package:itjobs/models/Company.dart';
import 'package:itjobs/models/Job.dart';
import 'package:itjobs/models/PreviousJob.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/previous/previous_bloc.dart';

class PreviousJobModal extends StatefulWidget {

  @override
  _PreviousJobModalState createState() => _PreviousJobModalState();
}

class _PreviousJobModalState extends State<PreviousJobModal> {

  final TextEditingController title = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController resps = TextEditingController();

  final labelTexts = [
    "Title",
    "Company Name",
    "Mention responsibilities"
  ];

  @override
  void dispose() {
    title.dispose();
    companyName.dispose();
    resps.dispose();
    super.dispose();
  }

  void _addPreviousJob(BuildContext ctx) {
    final respons = resps.text.split(new RegExp(r"\n")).where((element) => element.isNotEmpty).toList();
    final newPreviousJob = PreviousJob(
      job: Job(jobCompany: Company(companyName: companyName.text), jobTitle: title.text, ), 
      responsibilities: respons
    );
    BlocProvider.of<PreviousBloc>(ctx).add(PreviousAdded(prevJobAdded: newPreviousJob));
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<InputDecoration> textStyles = labelTexts.map((text) => InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      labelText: text
    )).toList();
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+50),
      child: Column(
        children: [
          TextField(
            controller: title,
            decoration: textStyles[0]
          ),
          TextField(
            controller: companyName,
            decoration: textStyles[1]
          ),
          TextField(
            controller: resps,
            decoration: textStyles[2],
          ),
          RaisedButton(
            child: Text("Add"),
            onPressed: () => _addPreviousJob(context),
          )
        ],
      ),
    );
  }
}