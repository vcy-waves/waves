import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    required this.queryLocation,
  });

  Function queryLocation;

  List<String> searchTerms = [
    '六塊厝',
    '白沙灣',
    '台北港',
    '八里風帆碼頭',
    '沙崙海水浴場',
    '淺水灣',
    '老梅綠石槽',
    '富基漁港',
    '跳石海岸',//跳石
    '中角灣',//中角灣
    '金山海濱公園',//金山
    '下寮海灘',//下寮
    '翡翠灣',//翡翠灣
    '深澳鐵道自行車',
    '鼻頭角',
    '澳底',
    '福隆海水浴場',
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
