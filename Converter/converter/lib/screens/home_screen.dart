import 'package:flutter/material.dart';
import 'conversion_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = ['Данные', 'Длина', 'Масса', 'Температура'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертер величин'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversionScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
