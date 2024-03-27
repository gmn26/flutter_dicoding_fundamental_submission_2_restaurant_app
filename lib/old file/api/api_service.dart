import 'dart:convert';

import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_detail.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_search.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';

  Future<Restaurant> allResto() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));

    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load List of Restaurants');
    }
  }

  Future<RestaurantDetail> detailResto(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail Information');
    }
  }

  Future<RestaurantSearch> findResto(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Can\'t find any Restaurant');
    }
  }
}
