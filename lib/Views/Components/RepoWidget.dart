import 'package:explore_github/Models/repo.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/app_text.dart';
import 'package:explore_github/Views/Components/avatar.dart';
import 'package:flutter/material.dart';

class RepoWidget extends StatelessWidget {
  RepoWidget({Key? key, required this.repo, this.onTap}) : super(key: key);
  final Repo repo;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(bottom: 8),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors().grey200, width: 1)),
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              splashColor: Colors.black54.withOpacity(0.1),
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(repo.name??"n/a",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Text("Author: ",style: TextStyle(fontSize: 12),),
                        Text(repo.owner?.login??"n/a",style: TextStyle(fontSize: 12,color: AppColors().secondaryColor),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
