import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/old%20file/api/api_service.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/data/model/restaurant_search.dart';
import 'package:dicoding_fundamental_submission_2_restaurant_app_with_api/widgets/restaurant_star_rate.dart';
import 'package:flutter/material.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  Future<RestaurantSearch>? _search;
  final TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _search = ApiService().findResto(queryController.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    _search = ApiService().findResto(value.toString());
                  });
                },
                controller: queryController,
                decoration: InputDecoration(
                  focusColor: Colors.transparent,
                  hintText: "Type here ...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _search,
        builder: (context, snapshot) {
          var state = snapshot.connectionState;

          if (state != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = snapshot.data?.restaurants[index];
                  return Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: restaurant.id,
                        );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        leading: Hero(
                          tag: restaurant!.pictureId,
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant.name),
                            RatingStars(counter: restaurant.rating.floor())
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No Internet Connection',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please check your internet connection and try again.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
