import 'package:flutter/material.dart';
import '../widgets/JobTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/jobs/jobs_bloc.dart';

enum SortFactor {Distance, DatePosted, Name}

class HomeScreen extends StatefulWidget {

  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

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
  SortFactor sortFactor;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    sortFactor = SortFactor.DatePosted;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6)
    );
    _slide1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0, 1/3,
          curve: Curves.linear
        )
      )
    );
    _slide2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          1/3, 2/3,
          curve: Curves.linear
        ),
      )
    );
    _slide3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          2/3, 1.0,
          curve: Curves.linear
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
    if (val <= 1/4) {
      return (1-4*val)*slideSize;
    }
    else if (val <= 3/4) {
      return 0;
    }
    return (4*val-3)*slideSize;
  }

  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;
    final textStyle = TextStyle(fontSize: 14, color: Colors.white);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('ITJobs menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () => Navigator.of(context).pushNamed("/profile"),
            ),
            ListTile(
              title: Text('Saved Jobs'),
              onTap: () => Navigator.of(context).pushNamed("/saved"),
            ),
            ListTile(
              title: Text("Applied Jobs"),
              onTap: () => Navigator.of(context).pushNamed("/applied")
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () => BlocProvider.of<LoginBloc>(context).add(LogoutInitiate()),
            )
          ],
        ),
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(Icons.menu, color: Colors.white),
                    onTap: () => _scaffoldKey.currentState.openDrawer(),
                  ),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
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
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.filter)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<JobsBloc, JobsState>(
                      builder: (context, state) {
                        final jobLists = state.jobs;
                        return ListView.separated(
                          itemBuilder: (context, index) => JobTile(job: jobLists[index]), 
                          separatorBuilder: (_, __) => SizedBox(height: 5), 
                          itemCount: jobLists.length
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: PopupMenuButton<SortFactor>(
          child: Icon(Icons.settings_input_composite),
          onSelected: (value) => setState(() {}),
          itemBuilder: (context) => <PopupMenuItem<SortFactor>>[
            PopupMenuItem<SortFactor>(
              value: SortFactor.Name,
              child: Text("By Name")
            ),
            PopupMenuItem<SortFactor>(
              value: SortFactor.DatePosted,
              child: Text("By Date Posted")
            ),
            PopupMenuItem<SortFactor>(
              value: SortFactor.Distance,
              child: Text("By Distance from Company HQ")
            )
          ],
        ),
        onPressed: () => print("Filter button was pressed"),
      ),
    );
  }
}