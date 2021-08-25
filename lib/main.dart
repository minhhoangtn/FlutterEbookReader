import 'package:ebook_reader/view/main_screen.dart';
import 'package:ebook_reader/view_models/details_provider.dart';
import 'package:ebook_reader/view_models/genre_provider.dart';
import 'package:ebook_reader/view_models/home_provider.dart';
import 'package:ebook_reader/view_models/pinned_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PinnedProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MainScreen(),
      ),
    );
  }
}
