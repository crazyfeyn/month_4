import 'package:flutter/material.dart';

class Mainscren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Sliver App Bar"),
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Dynamic toolbar"),
            ),
            expandedHeight: 200,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[(100 * (index % 9))],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minEx: 60,
              maxEx: 200,
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text("SliverPersistentHeader 3"),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemExtent: 160,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.teal[100 * (index % 9)],
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.red,
                    height: 50,
                  );
                },
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxEx;
  final double minEx;
  final Widget child;

  _SliverAppBarDelegate(
      {required this.maxEx, required this.minEx, required this.child});

  @override
  Widget build(Object context, double shrinkOfset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxEx;

  @override
  double get minExtent => minEx;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}