class Response {
  String? error_flag;
  dynamic data;
  int? count;
  String? message;

  Response({this.error_flag, this.data, this.count, this.message});

  Response.fromJson(Map<String, dynamic> json) {
    error_flag = json['error_flag'];
    data = json['data'];
    count = json['count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_flag'] = this.error_flag;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['count'] = this.count;
    data['message'] = this.message;
    return data;
  }
}
