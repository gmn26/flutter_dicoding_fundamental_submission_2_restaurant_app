import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/old%20file/api/api_service.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_detail.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/widgets/getx.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/widgets/restaurant_star_rate.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Future<RestaurantDetail>? _details;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)?.settings.arguments as String;
    _details = ApiService().detailResto(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _details,
        builder: (context, snapshot) {
          var state = snapshot.connectionState;

          if (state != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var detail = snapshot.data;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    flexibleSpace: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: detail!.restaurant.pictureId,
                              child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/medium/${detail.restaurant.pictureId}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color.fromARGB(255, 129, 129, 129)
                                      .withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 24,
                            left: 24,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    toolbarHeight: 150,
                    expandedHeight: 150,
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.restaurant.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.pin_drop,
                                        color: Colors.red,
                                      ),
                                      Text(detail.restaurant.city),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Rate : "),
                                      RatingStars(
                                          counter:
                                              detail.restaurant.rating.floor()),
                                      Text(detail.restaurant.rating.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              const GetXWidgets(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "About this resto",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                        ),
                                        child: Text(
                                          detail.restaurant.description,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Foods",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detail.restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      Text(
                                        detail
                                            .restaurant.menus.foods[index].name,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Drinks",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detail.restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      Text(
                                        detail.restaurant.menus.drinks[index]
                                            .name,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text("Kosong");
            }
          }
        },
      ),
    );
  }
}
