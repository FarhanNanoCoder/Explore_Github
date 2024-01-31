class GithubUser{
  int? id;
  String? login;
  String? avatarUrl;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;
  String? name;
  String? company;
  String? location;
  String? bio;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;

  GithubUser({
    this.id,
    this.login,
    this.avatarUrl,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.name,
    this.company,
    this.location,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following

  });


  factory GithubUser.fromJson(Map<String,dynamic> json){
    return GithubUser(
      id: json["id"],
      login: json["login"],
      avatarUrl: json["avatar_url"],
      url: json["url"],
      htmlUrl: json["html_url"],
      followersUrl: json["followers_url"],
      followingUrl: json["following_url"],
      gistsUrl: json["gists_url"],
      starredUrl: json["starred_url"],
      subscriptionsUrl: json["subscriptions_url"],
      organizationsUrl: json["organizations_url"],
      reposUrl: json["repos_url"],
      eventsUrl: json["events_url"],
      receivedEventsUrl: json["received_events_url"],
      type: json["type"],
      siteAdmin: json["site_admin"],
      name: json["name"],
      company: json["company"],
      location: json["location"],
      bio: json["bio"],
      publicRepos: json["public_repos"],
      publicGists: json["public_gists"],
      followers: json["followers"],
      following: json["following"],

    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = {};
    data["id"] = id;
    data["login"] = login;
    data["avatar_url"] = avatarUrl;
    data["url"] = url;
    data["html_url"] = htmlUrl;
    data["followers_url"] = followersUrl;
    data["following_url"] = followingUrl;
    data["gists_url"] = gistsUrl;
    data["starred_url"] = starredUrl;
    data["subscriptions_url"] = subscriptionsUrl;
    data["organizations_url"] = organizationsUrl;
    data["repos_url"] = reposUrl;
    data["events_url"] = eventsUrl;
    data["received_events_url"] = receivedEventsUrl;
    data["type"] = type;
    data["site_admin"] = siteAdmin;
    data["name"] = name;
    data["company"] = company;
    data["location"] = location;
    data["bio"] = bio;
    data["public_repos"] = publicRepos;
    data["public_gists"] = publicGists;
    data["followers"] = followers;
    data["following"] = following;
    
    return data;
  }

}