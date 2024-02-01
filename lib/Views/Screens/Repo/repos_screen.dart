import 'dart:async';

import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/github_user.dart';
import 'package:explore_github/Models/repo.dart';
import 'package:explore_github/Repositories/github_user_repository.dart';
import 'package:explore_github/Repositories/repor_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/app_text.dart';
import 'package:explore_github/Views/Components/Core/app_text_form_field.dart';
import 'package:explore_github/Views/Components/RepoWidget.dart';
import 'package:explore_github/Views/Components/avatar.dart';
import 'package:explore_github/Views/Screens/Repo/repo_details_screen.dart';
import 'package:explore_github/Views/Screens/User/github_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ReposScreen extends StatefulWidget {
  static const String routeName = "/ReposScreen";
  GithubUser? githubUser;
  ReposScreen({super.key, this.githubUser});

  @override
  State<ReposScreen> createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  int page = 1;
  int perPage = 10;
  String? sort;
  String? order;
  final _pagingController = PagingController<int, Repo>(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      handleGetRepos(pageKey: pageKey);
    });
  }

  void handleGetRepos({bool refresh = false, int pageKey = 0}) async {
    if (refresh) {
      page = 1;
      pageKey = 0;
      _pagingController.refresh();
      // _pagingController.itemList = [];
    } else {
      try {
        print("pageKey: $pageKey");
        APIResponse<List<Repo>> response;
        if (widget.githubUser != null) {
          response = await RepoRepository.getReposByUser(
            username: widget.githubUser!.login!,
            page: page++,
            perPage: perPage,
            sort: sort,
            order: order,
            // query: _searchController.text,
          );
        } else {
          response = await RepoRepository.getAllRepos(
            page: page++,
            perPage: perPage,
            sort: sort,
            order: order,
            query: _searchController.text,
          );
        }
        if (response.data != null) {
          if (response.data!.length < perPage) {
            _pagingController.appendLastPage(response.data!);
          } else {
            _pagingController.appendPage(
                response.data!, (pageKey + response.data!.length) as int?);
          }
          // totalSalesAmount = _pagingController.itemList?.fold(0.0, (previousValue, element) => (previousValue??0)+(element.totalAmount??0))??0;
        }
      } catch (e) {
        print(e);
        _pagingController.error = e;
      }
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        // appBar: AppBar(
        //   title: Text("Github  users"),
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.githubUser != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors().grey100,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Avatar(
                        url: widget.githubUser?.avatarUrl ?? "",
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.githubUser?.login ?? "",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              AppText(
                      text: widget.githubUser != null
                          ? "Repositories: "
                          : "Search for Repositoires",
                      color: AppColors().textColor,
                      style: "bold",
                      size: 24)
                  .getText(),
              const SizedBox(
                height: 24,
              ),
              if (widget.githubUser == null)
                AppInputFormField(
                  controller: _searchController,
                  hint: "Search by respository name",
                  prefixIcon: Icon(Icons.search_outlined),
                  onChange: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      handleGetRepos(refresh: true);
                    });
                  },
                  suffixIcon: InkWell(
                    onTap: () {
                      _searchController.clear();
                      handleGetRepos(refresh: true);
                    },
                    child: const Icon(Icons.close_rounded),
                  ),
                ),
              if (widget.githubUser == null)
                const SizedBox(
                  height: 24,
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    handleGetRepos(refresh: true);
                  },
                  child: PagedListView<int, Repo>(
                      pagingController: _pagingController,
                      shrinkWrap: true,
                      // padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      builderDelegate: PagedChildBuilderDelegate<Repo>(
                        itemBuilder: (context, repo, index) => RepoWidget(
                          repo: repo,
                          onTap: () {
                            if (widget.githubUser == null) {
                              Navigator.pushNamed(
                                  context, RepoDetailsScreen.routeName,
                                  arguments: repo.id);
                            }
                          },
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
