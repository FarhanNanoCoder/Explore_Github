import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/github_user.dart';
import 'package:explore_github/Repositories/github_user_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Views/Components/Core/app_button.dart';
import 'package:explore_github/Views/Components/avatar.dart';
import 'package:explore_github/Views/Screens/Repo/repos_screen.dart';
import 'package:flutter/material.dart';

class GithubUserDetailsScreen extends StatefulWidget{
  static const routeName = "/GithubUserDetails";
  final String? githubUsername;
  GithubUserDetailsScreen({Key? key, required this.githubUsername}) : super(key: key);

  @override
  State<GithubUserDetailsScreen> createState() => _GithubUserDetailsScreenState();
}

class _GithubUserDetailsScreenState extends State<GithubUserDetailsScreen> {


  @override
  void initState() {
    super.initState();
  //  handleGetData();
  }

  void handleGetData()async{
    APIResponse<GithubUser>? res = await GithubUserRepository.getGithubUserDetails(username: widget.githubUsername!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Github User Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: FutureBuilder(
          future: GithubUserRepository.getGithubUserDetails(username: widget.githubUsername??""), 
          builder: ((context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.hasData){
              return Column(
                children: [
                  const SizedBox(height: 16,),
                  Avatar(url: snapshot.data?.data?.avatarUrl??"", height: 150, width: 150,),
                  const SizedBox(height: 16),
                  Text(snapshot.data?.data?.name??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                 
                  Text(snapshot.data?.data?.login??"",style: TextStyle(fontSize: 14,color: AppColors().secondaryColor),),
                   Container(
                    
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors().grey100,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,color: AppColors().grey600,size: 16,),
                            const SizedBox(width: 2,),
                            Text(snapshot.data?.data?.location??"n/a",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),
                        const SizedBox(width: 16,),
                        Text("|"),
                        const SizedBox(width: 16,),
                        Row(
                          children: [
                            
                            Icon(Icons.work_outline_rounded,color: AppColors().grey600,size: 16,),
                             const SizedBox(width: 2,),
                            Text(snapshot.data?.data?.company??"n/a",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 8),
                  Text(snapshot.data?.data?.bio??"",textAlign: TextAlign.center,style: TextStyle(color: AppColors().grey600),),
                  //a container to place location and company data
                 
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors().grey100,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Followers",style: TextStyle(color: AppColors().grey600),),
                            Text(snapshot.data?.data?.followers.toString()??"n/a",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Following",style: TextStyle(color: AppColors().grey600),),
                            Text(snapshot.data?.data?.following.toString()??"n/a",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Public Repos",style: TextStyle(color: AppColors().grey600),),
                            Text(snapshot.data?.data?.publicRepos.toString()??"n/a",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  AppButton(context: context).getOutlinedTextButtton(title: "See repositories", onPressed: (){
                    Navigator.pushNamed(context, ReposScreen.routeName,arguments: snapshot.data?.data??null);
                  })
                ],
              );
            }
            return Center(child: Text("No Data"),);
          })),
      )
    );
  }
}