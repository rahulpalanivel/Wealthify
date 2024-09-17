import 'package:app/domain/repository.dart' as repository;
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category, required this.value});
  final String category;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(repository.iconForCategory(category), size: 30),
              Text(
                category,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                repository.formatAmount(value),
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
