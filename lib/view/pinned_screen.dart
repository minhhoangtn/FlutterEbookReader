import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/view/details_screen.dart';
import 'package:ebook_reader/view_models/pinned_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Reading Later',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<PinnedProvider>(context, listen: false).getPinnedList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            );
          }
          return Consumer<PinnedProvider>(
              builder: (context, pinnedProvider, child) {
            return pinnedProvider.pinnedList.isEmpty
                ? _buildEmpty()
                : _buildPinnedList(pinnedProvider);
          });
        },
      ),
    );
  }

  ListView _buildPinnedList(PinnedProvider pinnedProvider) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: pinnedProvider.pinnedList.length,
      itemBuilder: (context, index) {
        final Entry entry = Entry.fromJson(
            jsonDecode(pinnedProvider.pinnedList[index]['entry'] as String)
                as Map<String, dynamic>);
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsScreen(entry: entry)));
          },
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) async {
              await pinnedProvider.removePinnedItem(entry.id!.t!);
            },
            confirmDismiss: (direction) => showDialog<bool>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      content: const Text(
                        'Are you sure 😑',
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16),
                            )),
                      ],
                    )),
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: entry.link![1].href!,
                      placeholder: (context, url) => Container(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'images/book_placeholder.png',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title!.t!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        Text(
                          entry.author!.name!.t!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Center _buildEmpty() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 300,
          child: Image.asset(
            'images/empty1.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 300,
          child: const Text(
            'Oops ! You have read all pinned books, please add more 🙄',
            style: TextStyle(fontSize: 20),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
