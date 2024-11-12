import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
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
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();

  SearchThreadFilter _searchThreadFilter = SearchThreadFilter.all;
  List<Thread> _threads = [];
  bool _hasMoreThreads = true;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        _onSearch(_searchController.text);
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasMoreThreads && !_isFetching) {
          _onSearch(_searchController.text, isFetchMore: true);
        }
      }
    });
    _onSearch('');
  }

  void _onSearch(String value, {bool isFetchMore = false}) async {
    _isFetching = true;
    setState(() {});

    final page = isFetchMore ? (_threads.length / 10).ceil() + 1 : 1;

    final (threads, hasMoreThreads) = await context
        .read<ChannelsManager>()
        .getCurrentThreadsManager()
        .searchThreads(
          value,
          filter: _searchThreadFilter,
          page: page,
        );

    if (isFetchMore) {
      _hasMoreThreads = hasMoreThreads;
      for (final fetchThread in threads) {
        if (_threads.indexWhere((thread) => thread.id == fetchThread.id) ==
            -1) {
          _threads.add(fetchThread);
        }
      }
    } else {
      _threads = threads;
      _hasMoreThreads = hasMoreThreads;
    }

    _isFetching = false;
    setState(() {});
  }

  void _onFilterChanged(SearchThreadFilter filter) {
    _searchThreadFilter = filter;
    _searchFocusNode.unfocus();
    _threads = [];
    setState(() {});

    _onSearch(_searchController.text);
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
                  controller: _searchController,
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
                      onPressed: filter == _searchThreadFilter
                          ? null
                          : () => _onFilterChanged(filter),
                    );
                  },
                ),
              ),
            ],
          ),

          // No threads
          if (!_isFetching && _threads.isEmpty) ...[
            const SizedBox(height: 20.0),
            const Text('No threads found'),
          ],

          // Threads
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _threads.length,
              itemBuilder: (context, index) =>
                  _buildThreadDetail(_threads, index),
            ),
          ),

          if (_isFetching) getLoadingAnimation(context),
        ],
      ),
    );
  }

  Widget _buildThreadDetail(List<Thread> threads, int index) {
    return ThreadDetail(threads[index]);
  }
}
