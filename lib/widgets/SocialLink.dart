import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLink extends StatelessWidget {

  final Map<String, String> socialLink;

  SocialLink({this.socialLink});

  void _launchWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String socialName = socialLink.keys.toList()[0];
    final String socialURL = socialLink.values.toList()[0];
    return GestureDetector(
      onTap: () => _launchWebsite(socialURL),
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.yellow))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF00cec9),
              child: Text(socialName[0]),
            ),
            SizedBox(width: 20),
            Text(socialName),
            Spacer(
              flex: 1,
            ),
            Icon(Icons.web)
          ],
        ),
      ),
    );
  }
}