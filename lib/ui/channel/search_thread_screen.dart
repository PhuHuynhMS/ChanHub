import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../../common/constants.dart';
import '../../common/enums.dart';
import '../shared/utils/index.dart';
import './widgets/index.dart';

class SearchThreadScreen extends StatefulWidget {
  static const String routeName = '/thread/search';

  const SearchThreadScreen({super.key});

  @override
  State<SearchThreadScreen> createState() => _SearchThreadScreenState();
}

class _SearchThreadScreenState extends State<SearchThreadScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  SearchThreadFilter _searchThreadFilter = SearchThreadFilter.all;
  List<Thread> threads = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        _onSearch(_searchController.text);
      }
    });
  }

  void _onSearch(String value) {
    print('Search: $value');
  }

  void _onFilterChanged(SearchThreadFilter filter) {
    _searchThreadFilter = filter;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Thread'),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 10.0,
                  bottom: 0.0,
                ),
                child: TextFormField(
                  decoration: underlineInputDecoration(
                    context,
                    'Enter keyword',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  focusNode: _searchFocusNode,
                ),
              ),

              // Filter buttons
              SizedBox(
                height: 50.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: searchThreadFilterString.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10.0),
                  itemBuilder: (context, index) {
                    final filter =
                        searchThreadFilterString.keys.elementAt(index);
                    return FilterButton(
                      filter: filter,
                      value: searchThreadFilterString[filter]!,
                      isSelected: _searchThreadFilter == filter,
                      onPressed: () => _onFilterChanged(filter),
                    );
                  },
                ),
              ),
            ],
          ),

          // Threads
          Expanded(
            child: ListView.builder(
              itemCount: threads.length,
              itemBuilder: (context, index) =>
                  _buildThreadDetail(threads, index),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildThreadDetail(List<Thread> threads, int index) {
    // return ThreadDetail(threads[index]);
    return const SizedBox();
  }
}
