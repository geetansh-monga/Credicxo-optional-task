import 'package:flutter/material.dart';
import 'package:credicxo_task/constants/FontStyle.dart';

class InfoWidget extends StatelessWidget {
  final String header;
  final String content;

  InfoWidget({@required this.header, @required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header, style: kBold),
        SizedBox(height: 5),
        Text(
          content,
          style: kContent,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
