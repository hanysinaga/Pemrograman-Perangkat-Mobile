import 'package:flutter/material.dart';
import 'package:learn/utils/assets_path.dart';
import 'package:learn/utils/const_dimensions.dart';
import 'package:learn/utils/route/route_constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer.dart';
import '../theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override //progress
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<bool> _isImageClicked = List.generate(7, (index) => false);
  List<double> _progressValues = List.generate(7, (index) => 0.0);

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 7; i++) {
        _progressValues[i] = prefs.getDouble('progress_$i') ?? 0.0;
      }
    });
  }

  Future<void> _updateProgress(int index, double progress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progressValues[index] = progress;
    });
    await prefs.setDouble('progress_$index', progress);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 1),
            child: IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCategoryCard(
              context: context,
              title: "ALPHABETS",
              image: AssetsPath.getAlphabetImage(Alphabets.alphabets),
              shortDescription:
                  "Learn A to Z with pronunciation and an example",
              route: AllRoutesConstant.atozRoute,
              index: 0,
              progress: _progressValues[0],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "ANIMALS",
              image: AssetsPath.getAnimalImage(Animals.animals),
              shortDescription: "Learn about animals and their voices",
              route: AllRoutesConstant.animalRoute,
              index: 1,
              progress: _progressValues[1],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "BODY PARTS",
              image: AssetsPath.getBodyImage(Body.body),
              shortDescription:
                  "Know about body parts and their pronunciation.",
              route: AllRoutesConstant.partsRoute,
              index: 2,
              progress: _progressValues[2],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "BIRDS",
              image: AssetsPath.getBirdImage(Birds.birds),
              shortDescription: "Look out for Birds with their sounds.",
              route: AllRoutesConstant.birdsRoute,
              index: 3,
              progress: _progressValues[3],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "COLOURS",
              image: AssetsPath.getColoursImage(ColorImages.colorsCover),
              shortDescription: "Explore and learn about the colours!",
              route: AllRoutesConstant.colourRoute,
              index: 4,
              progress: _progressValues[4],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "FLOWERS",
              image: AssetsPath.getFlowerImage(Flowers.flowerBanner),
              shortDescription: "Explore beauty of nature flowers.",
              route: AllRoutesConstant.flowerRoute,
              index: 5,
              progress: _progressValues[5],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context: context,
              title: "FRUITS & VEGETABLES",
              image: 'assets/fruitsVeges/cover.jpg',
              shortDescription:
                  "Explore and learn about Fruits and Vegetables!",
              route: AllRoutesConstant.fruitRoute,
              index: 6,
              progress: _progressValues[6],
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required String image,
    required String shortDescription,
    required String route,
    required int index,
    required double progress,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isImageClicked[index] = !_isImageClicked[index];
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushNamed(context, route).then((_) {
            // Simulate progress increment after completing the material
            double newProgress = _progressValues[index] + 0.1;
            if (newProgress > 1.0) {
              newProgress = 1.0;
            }
            _updateProgress(index, newProgress);
          });
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _isImageClicked[index]
                  ? ConstantDimensions.heightSmallImage
                  : ConstantDimensions.heightBigImage,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                shortDescription,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 5,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
