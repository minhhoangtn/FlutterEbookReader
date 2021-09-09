import 'package:flutter/material.dart';

class BookErrorImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'images/book_placeholder.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
