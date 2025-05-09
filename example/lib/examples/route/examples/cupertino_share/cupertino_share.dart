// ignore_for_file: discarded_futures

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoSharePage extends StatelessWidget {
  const CupertinoSharePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CupertinoNavigationBar appBar = CupertinoNavigationBar(
      middle: const Column(
        children: <Widget>[
          Text('New York', style: TextStyle(fontWeight: FontWeight.normal)),
          Text('1 February 11:45', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
        ],
      ),
      trailing: Text('Edit', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
    );
    return Scaffold(
      appBar: appBar,
      body: CupertinoPageScaffold(
        child: Center(
          child: Hero(
            tag: 'image',
            placeholderBuilder:
                (BuildContext context, Size heroSize, Widget child) => ClipRect(
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8)),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Image.asset('assets/demo_image.jpeg'),
                    ),
                  ),
                ),
            child: ClipRRect(borderRadius: BorderRadius.circular(0), child: Image.asset('assets/demo_image.jpeg')),
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  Widget bottomAppBar(BuildContext context) => BottomAppBar(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CupertinoButton(
          child: const Icon(CupertinoIcons.share, size: 28),
          onPressed: () {
            Navigator.of(context).push(CupertinoSheetRoute<void>(builder: (context) => const PhotoShareBottomSheet()));
          },
        ),
        const CupertinoButton(onPressed: null, child: Icon(CupertinoIcons.heart, size: 28)),
        const CupertinoButton(onPressed: null, child: Icon(CupertinoIcons.delete, size: 28)),
      ],
    ),
  );
}

class PhotoShareBottomSheet extends StatelessWidget {
  const PhotoShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
    child: Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
        extendBodyBehindAppBar: true,
        appBar: appBar(context),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          primary: true,
          slivers: <Widget>[
            SliverSafeArea(
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 318,
                  child: ListView(
                    padding: const EdgeInsets.all(12).copyWith(right: MediaQuery.sizeOf(context).width / 2 - 100),
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Hero(
                          tag: 'image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/demo_image.jpeg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/demo_image.jpeg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/demo_image.jpeg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            sliverContactsSection(context),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                padding: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final Item app = apps[index];
                    return Container(
                      width: 72,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: <Widget>[
                          Material(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 12,
                            shadowColor: Colors.black12,
                            child: ClipRRect(
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(app.imageUrl!), fit: BoxFit.cover),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            app.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: apps.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  List<Widget>.from(
                    actions.map<Widget>(
                      (Item action) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Text(action.title, style: CupertinoTheme.of(context).textTheme.textStyle),
                      ),
                    ),
                  ).addItemInBetween(const Divider(height: 1)),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  List<Widget>.from(
                    actions1.map<Widget>(
                      (Item action) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Text(action.title, style: CupertinoTheme.of(context).textTheme.textStyle),
                      ),
                    ),
                  ).addItemInBetween(const Divider(height: 1)),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  List<Widget>.from(
                    actions2.map<Widget>(
                      (Item action) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Text(action.title, style: CupertinoTheme.of(context).textTheme.textStyle),
                      ),
                    ),
                  ).addItemInBetween(const Divider(height: 1)),
                ),
              ),
            ),
            const SliverSafeArea(top: false, sliver: SliverPadding(padding: EdgeInsets.only(bottom: 20))),
          ],
        ),
      ),
    ),
  );

  Widget sliverContactsSection(BuildContext context) => SliverToBoxAdapter(
    child: Container(
      height: 132,
      padding: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final Item person = people[index];
          return Container(
            width: 72,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: <Widget>[
                Material(
                  shape: const CircleBorder(),
                  elevation: 12,
                  shadowColor: Colors.black12,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(person.imageUrl!),
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(person.title, maxLines: 2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
              ],
            ),
          );
        },
        itemCount: people.length,
      ),
    ),
  );

  PreferredSizeWidget appBar(BuildContext context) => PreferredSize(
    preferredSize: const Size(double.infinity, 74),
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: ColoredBox(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor..withValues(alpha: 0.8),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 18),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset('assets/demo_image.jpeg', fit: BoxFit.cover, height: 40, width: 40),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            '1 Photo selected',
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                'Options',
                                style: CupertinoTheme.of(
                                  context,
                                ).textTheme.actionTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(width: 2),
                              Icon(
                                CupertinoIcons.right_chevron,
                                size: 14,
                                color: CupertinoTheme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 14),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black..withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 24, color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
          ),
        ),
      ),
    ),
  );
}

class Item {
  Item(this.title, this.imageUrl);

  final String title;
  final String? imageUrl;
}

final List<Item> people = <Item>[
  Item('MacBook Pro', 'assets/MacBook.jpg'),
  Item('Jaime Blanco', 'assets/jaimeblasco.jpeg'),
  Item('Mya Johnston', 'assets/person1.jpeg'),
  // https://images.unsplash.com/photo-1520813792240-56fc4a3765a7'
  Item('Maxime Nicholls', 'assets/person4.jpeg'), //https://images.unsplash.com/photo-1568707043650-eb03f2536825'
  Item('Susanna Thorne', 'assets/person2.jpeg'), //https://images.unsplash.com/photo-1520719627573-5e2c1a6610f0
  Item('Jarod Aguilar', 'assets/person3.jpeg'),
  //https://images.unsplash.com/photo-1547106634-56dcd53ae883
];

final List<Item> apps = <Item>[
  Item('Messages', 'assets/message.png'),
  Item('Github', 'assets/github_app.png'),
  Item('Slack', 'assets/slack.png'),
  Item('Twitter', 'assets/twitter.png'),
  Item('Mail', 'assets/mail.png'),
];

final List<Item> actions = <Item>[Item('Copy Photo', null)];
final List<Item> actions1 = <Item>[
  Item('Add to Shared Album', null),
  Item('Add to Album', null),
  Item('Duplicate', null),
  Item('Hide', null),
  Item('Slideshow', null),
  Item('AirPlay', null),
  Item('Use as Wallpaper', null),
];

final List<Item> actions2 = <Item>[
  Item('Create Watch', null),
  Item('Save to Files', null),
  Item('Assign to Contact', null),
  Item('Print', null),
];

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween(T item) =>
      length == 0 ? this : (fold(<T>[], (List<T> r, T element) => <T>[...r, element, item])..removeLast());
}

class SimpleSliverDelegate extends SliverPersistentHeaderDelegate {
  SimpleSliverDelegate({required this.child, required this.height});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox(height: height, child: child);

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
