class Pagination{
  int? perPage;
  int? page;
  String? sort;
  String? order;
  int? totalCount;

  Pagination({this.perPage,this.page,this.sort,this.order,this.totalCount});

  factory Pagination.fromJson(Map<String,dynamic> json){
    return Pagination(
      perPage: json["per_page"]??10,
      page: json["page"]??1,
      sort: json["sort"],
      order: json["order"]??"desc",
      totalCount: json["total_count"]??0
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = {};
    data["per_page"] = perPage;
    data["page"] = page;
    data["sort"] = sort;
    data["order"] = order;
    data["total_count"] = totalCount;
    return data;
  }
}