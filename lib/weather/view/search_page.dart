import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Search'),
      ),
      body: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _textController,
              decoration:
                  const InputDecoration(labelText: 'City', hintText: 'Chicago'),
            ),
          )),
          IconButton(
              onPressed: () => Navigator.of(context).pop(_text),
              icon: const Icon(
                Icons.search,
                semanticLabel: 'Search',
              ))
        ],
      ),
    );
  }
}
