import 'package:explore_github/Repositories/repor_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Views/Components/avatar.dart';
import 'package:explore_github/Views/Screens/User/github_user_details_screen.dart';
import 'package:flutter/material.dart';

class RepoDetailsScreen extends StatefulWidget {
  static const String routeName = "/RepoDetailScreen";
  int? repoId;

  RepoDetailsScreen({super.key, this.repoId});

  @override
  State<RepoDetailsScreen> createState() => _RepoDetailsScreenState();
}

class _RepoDetailsScreenState extends State<RepoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        appBar: AppBar(
          title: Text("Repo Details"),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: FutureBuilder(
                future: RepoRepository.getRepoDetails(widget.repoId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if(!snapshot.hasData){
                    return Center(
                      child: Text("No Data"),);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(GithubUserDetailsScreen.routeName,arguments: snapshot.data!.data!.owner!.login);
                        },
                         child: Row(
                          children: [
                            Avatar(
                              url: snapshot.data?.data?.owner?.avatarUrl??"",
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8,),
                            Text(snapshot.data?.data?.owner?.login ?? "",style: TextStyle( fontSize: 14)),
                          ],
                         ),
                       ),
                       const SizedBox(height: 4,),
                      Text(snapshot?.data?.data?.name ?? "n/a", textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      Text('Last pushed: ${snapshot?.data?.data?.pushedAt ?? "n/a"}', textAlign: TextAlign.start,style: TextStyle( fontSize: 14,color: AppColors().grey600)),
                      const SizedBox(height: 16,),
                      Text(snapshot.data?.data?.description ?? "n/a", textAlign: TextAlign.start,style: TextStyle( fontSize: 14,color: AppColors().grey600)),
                      const SizedBox(height: 24,),
                    
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors().grey100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.star_border_outlined,size: 24,),
                                const SizedBox(height: 4,),
                                Text(snapshot.data?.data?.stargazersCount?.toString()??"n/a",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.remove_red_eye_outlined,size: 24,),
                                const SizedBox(height: 4,),
                                Text(snapshot.data?.data?.watchersCount?.toString()??"n/a",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.call_split_outlined,size: 24,),
                                const SizedBox(height: 4,),
                                Text(snapshot.data?.data?.forksCount?.toString()??"n/a",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  );
                })),
      ),
    );
  }
}
