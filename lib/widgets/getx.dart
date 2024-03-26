import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs; // "obs" makes the variable observable

  void increment() {
    count++;
  }
}

class GetXWidgets extends StatelessWidget {
  const GetXWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController counterController = Get.put(CounterController());
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text(
                'Likes: ${counterController.count}',
                style: const TextStyle(fontSize: 16),
              )),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              counterController.increment();
            },
            icon: const Icon(Icons.thumb_up),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
