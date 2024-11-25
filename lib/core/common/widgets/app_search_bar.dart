import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  const AppSearchBar({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText ?? 'Search',
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      trailing: const <Widget>[Icon(Icons.search)],
      padding:
          const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
      hintStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 12)),
    );
  }
}
