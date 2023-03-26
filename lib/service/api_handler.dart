import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classement.dart';
import 'api_const.dart';

class APIHandler {
  static Future<List<Response>> getAllProducts() async {
    var response = await http.get(Uri.parse(
        "https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?"));

    var data = jsonDecode(response.body);
    var listData = data['response']['ranks'];

    return Response.responseFromAPI(listData);

  }
}




