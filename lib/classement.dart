import 'package:prj_3/rank_games.dart';

class classement {
  Response? response;

  classement({this.response});

  classement.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (response != null) {
      data['response'] = response!;
    }
    return data;
  }
}

class Response {
  int? rollupDate;
  List<Ranks>? ranks;

  Response({this.rollupDate, this.ranks});

  Response.fromJson(Map<String, dynamic> json) {
    rollupDate = json['rollup_date'];
    if (json['ranks'] != null) {
      ranks = <Ranks>[];
      json['ranks'].forEach((v) {
        ranks!.add(new Ranks.fromJson(v));
      });
    }
  }

static List<Response> responseFromAPI(List responseAPI){
  print("value ${responseAPI[0]}");

  return responseAPI.map((val){
      return Response.fromJson(val);
    }).toList();
}
}

