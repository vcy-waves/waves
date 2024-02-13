import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    required this.queryLocation,
  });

  Function queryLocation;

  List<String> searchTerms = [
    'LiuKuaiCuo',
    'Baishawan',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var locationName in searchTerms) {
      if (locationName.contains(query)) {
        matchQuery.add(locationName);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            queryLocation(result);
            close(context, null);
            Navigator.pop(context);
          },
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var locationName in searchTerms) {
      if (locationName.contains(query)) {
        matchQuery.add(locationName);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            queryLocation(result);
            close(context, null);
            Navigator.pop(context);
          },
          title: Text(result),
        );
      },
    );
  }
}
