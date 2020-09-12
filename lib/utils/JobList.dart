import 'package:flutter/material.dart';
import 'package:itjobs/models/PreviousJob.dart';
import '../models/Job.dart';
import '../models/Company.dart';
import '../models/Location.dart';
import '../models/Tag.dart';

List<Company> companyList = [
  Company(
    companyName: "Google",
    companyLocation: Location(
      city: "Bangalore",
      state: "Hyderabad",
      latitude: 12.9716,
      longitude: 77.5946
    )
  ),
  Company(
    companyName: "Microsoft",
    companyLocation: Location(
      city: "Gurgaon",
      state: "Haryana",
      latitude: 28.4595,
      longitude: 77.0266
    )
  ),
  Company(
    companyName: "Flipkart",
    companyLocation: Location(
      city: "Bangalore",
      state: "Hyderabad",
      latitude: 28.4595,
      longitude: 77.0266
    )
  ),
  Company(
    companyName: "Cutshort",
    companyLocation: Location(
      city: "Pune",
      state: "Maharashtra",
      latitude: 18.5204,
      longitude: 73.8567
    )
  ),
  Company(
    companyName: "HackerEarth",
    companyLocation: Location(
      city: "Mumbai",
      state: "Maharashtra",
      latitude: 19.0760,
      longitude: 72.8777
    )
  ),
  Company(
    companyName: "Adobe",
    companyLocation: Location(
      city: "Ahmedabad",
      state: "Gujarat",
      latitude: 23.0225,
      longitude: 72.5714
    )
  ),
  Company(
    companyName: "HP",
    companyLocation: Location(
      city: "Delhi",
      state: "Delhi NCR",
      latitude: 28.7041,
      longitude: 77.1025
    )
  ),
  Company(
    companyName: "Dream Company",
    companyLocation: Location(
      city: "Begusarai",
      state: "Bihar",
      latitude: 25.4182,
      longitude: 86.1272,
    )
  )
];

List<List<Tag>> tagCombinations = [
  [Tag(tagName: "React", tagColor: Colors.blue), Tag(tagName: "MongoDB", tagColor: Colors.brown)],
  [Tag(tagName: "React Native", tagColor: Colors.blue), Tag(tagName: "Flutter", tagColor: Colors.lightBlueAccent[200])],
  [Tag(tagName: "React", tagColor: Colors.blue), Tag(tagName: "SQL", tagColor: Colors.lightBlue)],
  [Tag(tagName: "DSA", tagColor: Colors.yellow), Tag(tagName: "Angular", tagColor: Colors.red)],
  [Tag(tagName: "Scraping", tagColor: Colors.green), Tag(tagName: "Python", tagColor: Colors.lightBlue[500])]
];

List<Job> jobList = [
  Job(
    jobTitle: "Fullstack Engineer",
    jobCompany: companyList[0],
    jobDatePosted: DateTime.now().subtract(Duration(days: 5)),
    jobIsSaved: false,
    jobSalary: 80000,
    jobType: JobType.Fulltime,
    jobTags: tagCombinations[0]
  ),
  Job(
    jobTitle: "Backend Developer",
    jobCompany: companyList[1],
    jobDatePosted: DateTime.now().subtract(Duration(days: 10)),
    jobIsSaved: false,
    jobSalary: 100000,
    jobType: JobType.Fulltime,
    jobTags: tagCombinations[1]
  ),
  Job(
    jobTitle: "Python Developer",
    jobCompany: companyList[2],
    jobDatePosted: DateTime.now().subtract(Duration(days: 20)),
    jobSalary: 70000,
    jobType: JobType.PartTime,
    jobTags: tagCombinations[3]
  ),
  Job(
    jobTitle: "Python Intern",
    jobCompany: companyList[companyList.length-2],
    jobDatePosted: DateTime.now().subtract(Duration(days: 50)),
    jobSalary: 50000,
    jobType: JobType.Internship,
    jobTags: tagCombinations[4]
  ),
  Job(
    jobTitle: "MERN Stack Developer",
    jobCompany: companyList[companyList.length-1],
    jobDatePosted: DateTime.now().subtract(Duration(days: 17)),
    jobSalary: 200000,
    jobType: JobType.Fulltime,
    jobTags: tagCombinations[0]
  ),
  Job(
    jobTitle: "Laravel Developer",
    jobCompany: companyList[companyList.length-1],
    jobDatePosted: DateTime.now().subtract(Duration(days: 21)),
    jobSalary: 90000,
    jobType: JobType.Contract,
    jobTags: tagCombinations[0]
  ),
  Job(
    jobTitle: "MEAN Stack Developer",
    jobCompany: companyList[companyList.length-1],
    jobDatePosted: DateTime.now().subtract(Duration(days: 4)),
    jobSalary: 150000,
    jobType: JobType.Contract,
    jobTags: tagCombinations[0]
  )
];

List<PreviousJob> userPreviousJobs = [
  PreviousJob(job: jobList[1], responsibilities: [
    "Collaborating with designers to create beautiful UI",
    "Meeting with project managers and clients to establish project milestones",
    "Learn new technologies to keep up with current trends"
  ]),
  PreviousJob(job: jobList[3], responsibilities: [
    "Scraping websites to access valuable information",
    "Storing them in a local database and using them for data analysis",
    "Perform data analysis and gain valuable insight for client"
  ])
];

List<Map<String, String>> socialLinks = [
  {"Github": "https://github.com/t3chcrazy"},
  {"LinkedIn": "https://www.linkedin.com/in/abhishek-prashant-92b152a9/"},
  {"Codechef": "https://www.codechef.com/users/tech_crazy"},
  {"Hackerrank": "https://www.hackerrank.com/Tech_Crazy"}
];