
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Learn',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Center(
                child: Text(
                  'Learning app for kids',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              _buildSectionContent(
                context,
                'Learn is designed to provide a fun and interactive learning experience for kids. '
                'Our mission is to make learning enjoyable and accessible, encouraging curiosity and discovery in young minds. '
                'The app covers a wide range of topics to help children build a solid foundation of knowledge in a playful and engaging way.',
              ),
              const SizedBox(height: 16.0),
              _buildSectionTitle(context, 'Features:'),
              const SizedBox(height: 8.0),
              _buildFeature(
                context,
                'A-Z Alphabets',
                'Learn the alphabets with examples and pronunciation guides, making it easier for kids to recognize and remember letters.',
              ),
              _buildFeature(
                context,
                'Animals',
                'Discover animals, hear their sounds, and learn how to pronounce their names, fostering a love for nature and wildlife.',
              ),
              _buildFeature(
                context,
                'Body Parts',
                'Learn about different body parts, how to pronounce them, and gain short information, promoting awareness of their own bodies.',
              ),
              _buildFeature(
                context,
                'Birds',
                'Explore different birds and their voices, adding to the child’s knowledge about avian species.',
              ),
              _buildFeature(
                context,
                'Solar System',
                'Gain knowledge about the solar system, sparking interest in space and astronomy.',
              ),
              const SizedBox(height: 16.0),
              _buildSectionTitle(context, 'Upcoming Features:'),
              const SizedBox(height: 8.0),
              _buildFeature(
                context,
                'Shapes',
                'Learn about different shapes and their properties, enhancing cognitive and visual-spatial skills.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
    );
  }
}
