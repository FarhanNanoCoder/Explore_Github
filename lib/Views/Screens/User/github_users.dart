import 'dart:async';

import 'package:explore_github/Models/github_user.dart';
import 'package:explore_github/Repositories/github_user_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/app_text.dart';
import 'package:explore_github/Views/Components/Core/app_text_form_field.dart';
import 'package:explore_github/Views/Components/GithubUserWidget.dart';
import 'package:explore_github/Views/Screens/User/github_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GithubUsersScreen extends StatefulWidget {
  static const String routeName = "/DashboardScreen";

  @override
  State<GithubUsersScreen> createState() => _GithubUsersScreenState();
}

class _GithubUsersScreenState extends State<GithubUsersScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  int page = 1;
  int perPage = 10;
  String? sort;
  String? order;
  final _pagingController = PagingController<int, GithubUser>(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      handleGetGithubUsers(pageKey: pageKey);
    });
  }

  void handleGetGithubUsers({bool refresh = false, int pageKey = 0}) async {
    if (refresh) {
      page = 1;
      pageKey = 0;
      _pagingController.refresh();
      // _pagingController.itemList = [];
    } else {
      try {
        print("pageKey: $pageKey");
        var response = await GithubUserRepository.getAllGithubUsers(
          page: page++,
          perPage: perPage,
          sort: sort,
          order: order,
          query: _searchController.text,
        );
        if (response.data != null) {
          if (response.data!.length < perPage) {
            _pagingController.appendLastPage(response.data!);
          } else {
            _pagingController.appendPage(
                response.data!, pageKey + response.data!.length);
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
    return Scaffold(
      backgroundColor: AppColors().white,
      // appBar: AppBar(
      //   title: Text("Github  users"),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            AppText(
                    text: "Search for users",
                    color: AppColors().textColor,
                    style: "bold",
                    size: 24)
                .getText(),
            const SizedBox(
              height: 24,
            ),
            AppInputFormField(
              controller: _searchController,
              hint: "Search by username",
              prefixIcon: Icon(Icons.search_outlined),
              onChange: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  handleGetGithubUsers(refresh: true);
                });
              },
              suffixIcon: InkWell(
                onTap: () {
                  _searchController.clear();
                  handleGetGithubUsers(refresh: true);
                },
                child: const Icon(Icons.close_rounded),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  handleGetGithubUsers(refresh: true);
                },
                
                child: PagedListView<int, GithubUser>(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    
                    // padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    builderDelegate: PagedChildBuilderDelegate<GithubUser>(
                      itemBuilder: (context, user, index) => GithubUserWidget(
                        githubUser: user,
                        onTap: () {
                          Navigator.pushNamed(
                              context, GithubUserDetailsScreen.routeName,
                              arguments: user.login);
                        },
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
