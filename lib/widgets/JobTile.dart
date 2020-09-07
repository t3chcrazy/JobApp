import 'package:flutter/material.dart';
import 'SkillTag.dart';
import '../models/Job.dart';

class JobTile extends StatefulWidget {

  final Job job;

  JobTile({this.job});

  @override
  _JobTileState createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> with SingleTickerProviderStateMixin {

  AnimationController _heart;
  Animation _value;
  bool isFavorited;

  @override
  void initState() {
    isFavorited = false;
    super.initState();
    _heart = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
    );
    _value = Tween(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent: _heart,
      )
    );
  }

  @override
  void dispose() {
    _heart.dispose();
    super.dispose();
  }

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

  void _handleHeartPress() {
    setState(() {
      isFavorited = !isFavorited;
    });
    _heart.isCompleted? _heart.reverse(): _heart.forward();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: Style the job tile
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/jobdesc", arguments: widget.job),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.job.jobTitle, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text(mapJobTypeToString(widget.job.jobType), style: TextStyle(color: Colors.grey[700], fontSize: 12))
                      )
                    ],
                  ),
                  Text(widget.job.jobCompany.companyName),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.job.jobTags.map((tag) => SkillTag(skillTag: tag,)).toList(),
                  ),
                  Text(widget.job.jobCompany.companyLocation.city+", "+widget.job.jobCompany.companyLocation.state, style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 12))
                ],
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
                    child: AnimatedBuilder(
                      animation: _heart,
                      builder: (context, child) => Transform(
                        transform: Matrix4.identity()..scale(_value.value <= 0.3? 1+_value.value: 1.6-_value.value),
                        origin: Offset(12.5, 12.5),
                        child: child,
                      ),
                      child: Icon(
                        isFavorited? Icons.favorite: Icons.favorite_border, 
                        color: Colors.pink, size: 25
                      ),
                    ),
                    onTap: _handleHeartPress,
                  ),
                  Text("Posted ${DateTime.now().difference(widget.job.jobDatePosted).inDays.toString()} days ago", style: TextStyle(fontSize: 12))
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