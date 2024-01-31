import 'package:explore_github/Models/github_user.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/app_text.dart';
import 'package:explore_github/Views/Components/avatar.dart';
import 'package:flutter/material.dart';

class GithubUserWidget extends StatelessWidget{
  GithubUserWidget({super.key, required this.githubUser, this.onTap});
  final GithubUser githubUser;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: AppColors().white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors().grey200,width: 1)),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          splashColor: Colors.black54.withOpacity(0.1),
          onTap: onTap,
          child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             child: Row(
              children: [
                Avatar(
                  url: githubUser.avatarUrl,
                  height: 36,
                  width: 36,
                  
                ),
                SizedBox(width: 16,),
                AppText(text: githubUser.login??"n/a").getText(),
              ],
             ),
          ),
        ),
      ),
    );
  }

}