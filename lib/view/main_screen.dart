import 'package:ebook_reader/view/bookshelf_screen.dart';
import 'package:ebook_reader/view/explore_screen.dart';
import 'package:ebook_reader/view/home_screen.dart';
import 'package:ebook_reader/view/pinned_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _onItemTap(int index) {
    _controller.jumpToPage(index);
  }

  void _onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: _onPageChange,
        children: [
          HomeScreen(),
          ExploreScreen(),
          BookshelfScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Theme.of(context).accentColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              color: Theme.of(context).accentColor,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_stories,
              color: Theme.of(context).accentColor,
            ),
            label: 'Bookshelf',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grade,
              color: Theme.of(context).accentColor,
            ),
            label: 'Pinned',
          ),
        ],
        currentIndex: _page,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTap,
      ),
    );
  }
}
