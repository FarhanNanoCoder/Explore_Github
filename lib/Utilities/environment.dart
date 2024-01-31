import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String get baseGithubUrl => dotenv.env["BASE_GITHUB_API_URL"] ?? "https://api.github.com";
  static String get baseGithubDomain=> dotenv.env["BASE_GITHUB_DOMAIN"] ?? "api.github.com";
}