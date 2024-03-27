import 'dart:convert';

import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_detail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantDetailController extends GetxController {
  RestaurantDetailController({required this.id});
  final String id;

  Rx<RestaurantDetailInfo> restaurantDetailInfo = RestaurantDetailInfo(
    id: '',
    name: '',
    description: '',
    city: '',
    address: '',
    pictureId: '',
    categories: [],
    menus: Menus(foods: [], drinks: []),
    rating: 0.0,
    customerReviews: [],
  ).obs;

  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  Future<void> fetchRestaurantsDetail(String id) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final response = await http
          .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));

      if (response.statusCode == 200) {
        final restaurantDetailJson = jsonDecode(response.body);
        final RestaurantDetail restaurantDetailData =
            RestaurantDetail.fromJson(restaurantDetailJson);
        restaurantDetailInfo.value = restaurantDetailData.restaurant;
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
    fetchRestaurantsDetail(id);
    super.onInit();
  }
}
