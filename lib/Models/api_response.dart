class APIResponse<T>{
  T? data;
  bool? error;
  String? message;

  APIResponse({this.data,this.error=false,this.message});
}