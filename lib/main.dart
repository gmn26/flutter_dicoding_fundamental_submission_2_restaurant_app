import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/ui/restaurant_detail_page.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/ui/restaurant_list_page.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/ui/restaurant_search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/list',
      routes: {
        '/list': (context) => RestaurantListPage(),
        '/detail': (context) => const RestaurantDetailPage(),
        '/search': (context) => RestaurantSearchPage(),
      },
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
