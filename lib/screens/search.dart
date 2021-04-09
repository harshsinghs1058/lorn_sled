import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

TextEditingController _searchController = TextEditingController();

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
    );
  }
}

class SearchBar extends PreferredSize {
  @override
  final Size preferredSize = Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Spacer(),
              Icon(Icons.search),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width - 130,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  controller: _searchController,
                  onEditingComplete: () {
                    print(_searchController.toString());
                    print(_searchController?.text);
                  },
                  onSubmitted: (value) {
                    print(value);
                  },
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 20,
                      ),
                  decoration: InputDecoration.collapsed(
                    hintText: "Search...",
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.clear),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
