import 'package:flutter/material.dart';
import '../widgets/JobTile.dart';
import '../utils/JobList.dart';

class HomeScreen extends StatefulWidget {

  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  final double slideSize = 20;
  final double mainFactor = 0.76;
  final List<String> headerTexts = [
    "Find relevant jobs",
    "Search by skills",
    "Introduce you to the best companies"
  ];

  AnimationController _controller;
  Animation<double> _slide1;
  Animation<double> _slide2;
  Animation<double> _slide3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6)
    );
    _slide1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0, 1/3,
          curve: Curves.easeInCubic
        )
      )
    );
    _slide2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          1/3, 2/3,
          curve: Curves.easeInCubic
        ),
      )
    );
    _slide3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          2/3, 1.0,
          curve: Curves.easeInCubic
        )
      )
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double mapValueToPosition(double val) {
    if (val <= 1/3) {
      return (1-3*val)*slideSize;
    }
    else if (val <= 2/3) {
      return 0;
    }
    return (3*val-2)*slideSize;
  }

  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;
    final textStyle = TextStyle(fontSize: 14, color: Colors.white);
    //TODO: Complete slide animation
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: dimensions.width,
              height: dimensions.height*0.3,
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ITJobs can help you", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
                  SizedBox(height: 10),
                  Container(
                    height: slideSize,
                    child: Stack(
                      overflow: Overflow.clip,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) => Positioned(
                            top: mapValueToPosition(_slide1.value),
                            child: Text("Find relevant jobs", style: textStyle)
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) => Positioned(
                            top: mapValueToPosition(_slide2.value),
                            child: Text("Search by skills", style: textStyle)
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) => Positioned(
                            top: mapValueToPosition(_slide3.value),
                            child: Text("Introduce you to the best companies", style: textStyle)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top+10,
            width: dimensions.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(Icons.person, color: Colors.white),
                    onTap: () => print("Profile was pressed"),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: dimensions.height*(1-mainFactor),
            left: 0,
            width: dimensions.width,
            height: dimensions.height*mainFactor,
            child: Container(
              height: dimensions.height*mainFactor,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                boxShadow: [BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0,0),
                  blurRadius: 6,
                  spreadRadius: 0
                )]
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Expanded(
                  //   child: ListView.builder(
                      
                  //   ),
                  // )
                  JobTile(job: jobList[0],)
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}