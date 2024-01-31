import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(
      {Key? key,
      this.height = 48,
      this.width = 48,
      
      this.url,
      this.icon = Icons.person});
  double? height;
  double? width;
  String? url;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return url != null
        ? CircleAvatar(
            radius: height! / 2,
            backgroundImage: NetworkImage(url!),
          )
        : CircleAvatar(
            radius: height! / 2,
            child: Icon(icon),
          );
  }
}
