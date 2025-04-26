import 'package:flutter/material.dart';

class NestedScrollModal extends StatelessWidget {
  const NestedScrollModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text('Books'),
                    pinned: true,
                    expandedHeight: 150,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(tabs: tabs.map((String name) => Tab(text: name)).toList()),
                  ),
                ),
              ],
          body: TabBarView(
            children:
                tabs
                    .map(
                      (String name) => SafeArea(
                        top: false,
                        bottom: false,
                        child: Builder(
                          builder:
                              (BuildContext context) => CustomScrollView(
                                controller: PrimaryScrollController.of(context),
                                key: PageStorageKey<String>(name),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    // This is the flip side of the SliverOverlapAbsorber
                                    // above.
                                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8),
                                    // In this example, the inner scroll view has
                                    // fixed-height list items, hence the use of
                                    // SliverFixedExtentList. However, one could use any
                                    // sliver widget here, e.g. SliverList or SliverGrid.
                                    sliver: SliverFixedExtentList(
                                      // The items in this example are fixed to 48 pixels
                                      // high. This matches the Material Design spec for
                                      // ListTile widgets.
                                      itemExtent: 48,
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) => ListTile(title: Text('Item $index')),
                                        // The childCount of the SliverChildBuilderDelegate
                                        // specifies how many children this inner list
                                        // has. In this example, each tab has a list of
                                        // exactly 30 items, but this is arbitrary.
                                        childCount: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
