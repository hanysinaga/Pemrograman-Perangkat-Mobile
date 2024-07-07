import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  Future<int> getQuizScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('quiz_score') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
        future: getQuizScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Error loading score");
          } else {
            int score = snapshot.data ?? 0;
            return Text(
              "Last Quiz Score: $score",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          }
        },
      ),
    );
  }
}