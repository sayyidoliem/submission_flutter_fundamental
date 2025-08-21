import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Icon(Icons.fastfood, size: 40),
          SizedBox(height: 8),
          Text('Menu', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('IDR 15.000'),
        ],
      ),
    );
  }
}
