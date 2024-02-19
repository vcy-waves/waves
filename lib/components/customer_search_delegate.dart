import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    required this.queryLocation,
  });

  Function queryLocation;

  List<String> searchTerms = [
    'LiuKuaiCuo',
    'Baishawan',
    'Taipei port',
    'Bali Sailing Pier',
    'Shalun Beach',
    'Cianshuei Bay',
    'Laomei Green Reef',
    'Fuji fishing port',
    'Jump-stone Coast',//跳石
    'Zhongjiao Bay',//中角灣
    'Jinshan Beach',//金山
    'Xialiao Beach',//下寮
    'Green Bay',//翡翠灣
    '深澳鐵道自行車',
    'Bitou Cape',
    '澳底',
    'FuLong beach',
    '最東點',

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
