import 'package:explore_github/Utilities/environment.dart';

String get baseGithubUrl{
  return Environment.baseGithubUrl;
}

String get baseGithubDomain{
  return Environment.baseGithubDomain;
}

final headers = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};