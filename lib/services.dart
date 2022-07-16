import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:justotest/models.dart';

Future<RandomUser> fetchAPIData() async {
  RandomUser result;
  try {
    final response = await http.get(
      Uri.parse("https://randomuser.me/api/"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = RandomUser.fromJson(item);
    } else {
      throw Exception('Failed to load data from API, ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('err: $e');
  }
  return result;
}

class UserProvider extends ChangeNotifier {
  late RandomUser user;
  bool isLoading = false;

  fetchData() async {
    isLoading = true;
    user = await fetchAPIData();
    isLoading = false;
    notifyListeners();
  }
}
