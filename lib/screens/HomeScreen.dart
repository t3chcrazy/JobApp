import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import '../widgets/JobTile.dart';
import '../widgets/HomeFilter.dart';
import '../bloc/jobs/jobs_bloc.dart';
import '../models/Location.dart';
import '../models/Job.dart';
import '../models/Tag.dart';
import '../widgets/Drawer.dart';

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
  final TextEditingController _filter = TextEditingController();

  AnimationController _controller;
  Animation<double> _slide1;
  Animation<double> _slide2;
  Animation<double> _slide3;
  SortFactor sortFactor;
  Position currPosition;
  FocusNode _filterNode;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SearchTitle searchTitle;
  Tag favTag;
  JobType jobType;
  String _filterValue = "";

  @override
  void initState() {
    super.initState();
    searchTitle = SearchTitle.JobName;
    sortFactor = SortFactor.DatePosted;
    _filterNode = FocusNode();
    jobType = null;
    favTag = null;

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
    getPosition()
    .then((value) {
      currPosition = value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Position> getPosition() async {
    return await getCurrentPosition();
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

  void _handleSelecedFilter(SearchTitle selectedSearchFilter) {
    if (searchTitle == selectedSearchFilter) {
      return;
    }
    setState(() {
      searchTitle = selectedSearchFilter;
    });
    Navigator.of(context).pop();
  }

  void _handleJobType(JobType type) {
    setState(() {
      jobType = jobType == type? null: type;
    });
    Navigator.of(context).pop();
  }

  void _handleTagSelect(Tag tag) {
    setState(() {
      favTag = tag;
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => HomeFilter(
        activeTitle: searchTitle,
        activeType: jobType,
        handleSelectedFilter: _handleSelecedFilter,
        handleJobType: _handleJobType,
        handleTag: _handleTagSelect,
      )
    );
  }

  void _handleFieldChange(String val) {
    setState(() {
      _filterValue = val;
    });
  }

  void _applyCorrectFilter(List<Job> listJobs) {
    switch (searchTitle) {
      case SearchTitle.JobName:
        listJobs.retainWhere((element) => element.jobTitle.toLowerCase().startsWith(_filterValue.toLowerCase()));
        return;
      case SearchTitle.CompanyName:
        listJobs.retainWhere((element) => element.jobCompany.companyName.toLowerCase().startsWith(_filterValue.toLowerCase()));
        return;
      default:
        listJobs.retainWhere((element) => element.jobTags.any((element) => element.tagName.toLowerCase().startsWith(_filterValue.toLowerCase())));
        return;
    }
  }

  LatLng _convertToLatLng(double lat, double lng) => LatLng(lat, lng);

  int _compareDistance(Location a, Location b) {
    final userLocation = _convertToLatLng(currPosition.latitude, currPosition.longitude);
    final locationA = _convertToLatLng(a.latitude, a.longitude);
    final locationB = _convertToLatLng(b.latitude, b.longitude);
    final Distance distance = Distance();
    final distanceA = distance.as(LengthUnit.Kilometer, locationA, userLocation);
    final distanceB = distance.as(LengthUnit.Kilometer, locationB, userLocation);
    return (distanceA-distanceB).round();
  }

  void _sortByCorrectOrder(List<Job> listJobs) {
    switch (sortFactor) {
      case SortFactor.DatePosted:
        listJobs.sort((a, b) => a.jobDatePosted.compareTo(b.jobDatePosted));
        return;
      case SortFactor.Distance:
        listJobs.sort((a, b) => _compareDistance(a.jobCompany.companyLocation, b.jobCompany.companyLocation));
        return;
      default:
        listJobs.sort((a, b) => a.jobTitle.compareTo(b.jobTitle));
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size dimensions = MediaQuery.of(context).size;
    final textStyle = TextStyle(fontSize: 14, color: Colors.white);

    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
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
                    onTap: () => Navigator.of(context).pushNamed("/profile"),
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
                            controller: _filter,
                            autofocus: false,
                            focusNode: _filterNode,
                            onChanged: _handleFieldChange,
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
                          onTap: _showFilterModal,
                          child: Icon(Icons.filter)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<JobsBloc, JobsState>(
                      builder: (context, state) {
                        final jobLists = state.jobs.sublist(0);
                        if (jobType != null) {
                          jobLists.retainWhere((element) => element.jobType == jobType);
                        }
                        if (favTag != null) {
                          jobLists.where((element) => element.jobTags.contains(favTag));
                        }
                        _applyCorrectFilter(jobLists);
                        _sortByCorrectOrder(jobLists);
                        return ListView.separated(
                          itemBuilder: (context, index) => JobTile(job: jobLists[index]), 
                          separatorBuilder: (_, __) => SizedBox(height: 15), 
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          child: PopupMenuButton<SortFactor>(
            child: Icon(Icons.settings_input_composite),
            onSelected: (value) => setState(() {
              sortFactor = value;
            }),
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
      ),
    );
  }
}