import 'dart:convert';

import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_search.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantSearchController extends GetxController {
  RestaurantSearchController({required this.query});
  final String query;

  RxList<RestaurantSearchElement> restaurantSearchElement =
      RxList<RestaurantSearchElement>();
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  Future<void> fetchRestaurantSearch(String query) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final response = await http.get(
          Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

      if (response.statusCode == 200) {
        final restaurantSearchJson = jsonDecode(response.body);
        final RestaurantSearch restaurantSearch =
            RestaurantSearch.fromJson(restaurantSearchJson);
        restaurantSearchElement.assignAll(restaurantSearch.restaurants);
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRestaurantSearch(query);
    super.onInit();
  }
}
