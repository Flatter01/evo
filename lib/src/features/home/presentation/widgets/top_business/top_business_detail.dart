import 'package:evo/src/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TopBusinessDetail extends StatelessWidget {
  const TopBusinessDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1548013146-72479768bada',
                width: double.infinity,
                height: 550,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 70,
                left: 16,
                child: _iconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 70,
                right: 16,
                child: _iconButton(
                  icon: Icons.favorite_border,
                  onTap: () {},
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.42,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rinjani Mountain',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The mighty Rinjani mountain of Gunung Rinjani is a massive volcano which towers over the island of Lombok. A climb to the top is one of the most exhilarating experiences you can have in Indonesia. At 3,726 meters tall, Gunung Rinjani is the second highest mountain in Indonesia.',
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text('4.8'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _previewImage(
                        'https://images.unsplash.com/photo-1548013146-72479768bada',
                      ),
                      _previewImage(
                        'https://cdn2.tu-tu.ru/image/pagetree_node_data/1/f39a009d84795d82d877260f7d095211/',
                      ),
                      _previewImage(
                        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
                      ),
                      _previewImage(
                        'https://images.unsplash.com/photo-1562564055-71e051d33c19',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Виджет превью изображения
  static Widget _previewImage(String url) {
    return Container(
      width: 92,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Иконка-кнопка
  static Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }
}
