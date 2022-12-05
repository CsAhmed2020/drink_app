
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title ;
  const TitleSection({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(alignment: Alignment.topLeft,
          child: Text(title,style: Theme.of(context).textTheme.headline3)),
    );
  }
}