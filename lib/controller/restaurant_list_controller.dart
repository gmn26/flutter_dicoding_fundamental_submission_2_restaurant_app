import 'dart:convert';

import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantListController extends GetxController {
  final RxList<RestaurantElement> restaurantsList = RxList<RestaurantElement>();
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  Future<void> fetchRestaurants() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final response =
          await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

      if (response.statusCode == 200) {
        final restaurantJson = jsonDecode(response.body);
        final Restaurant restaurant = Restaurant.fromJson(restaurantJson);
        restaurantsList.assignAll(restaurant.restaurants);
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRestaurants();
    super.onInit();
  }
}
