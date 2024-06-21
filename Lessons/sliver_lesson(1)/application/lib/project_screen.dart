import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => ProjectScreenState();
}

class ProjectScreenState extends State<ProjectScreen> {
  List<String> appbarImageList = [
    'assets/image_1.png',
    'assets/image_2.png',
    'assets/image_3.png'
  ];
  int i = 0;

  void toggleImage() {
    if (i < appbarImageList.length - 1) {
      i++;
    } else {
      i = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 100,
            actions: [
              InkWell(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                  ),
                ),
              ),
              const SizedBox(width: 10)
            ],
            leading: InkWell(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            centerTitle: true,
            title: const Text(
              "Order details",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                onTap: () => toggleImage(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(
                        appbarImageList[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 180.0,
                      child: Row(
                        children:
                            List.generate(appbarImageList.length, (int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  i == index ? Colors.white : Colors.amber,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 400,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minEx: 20,
                maxEx: 30,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.amber),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.71,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset(
                            'assets/image_2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$120',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_outline))
                        ],
                      ),
                      Text(
                        'Pull & bear men\'s',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      )
                    ],
                  );
                },
                childCount: 10,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minEx: 20,
                maxEx: 30,
                child: const Text(
                  textAlign: TextAlign.left,
                  'Men\'s fashion',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.amber),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 27, 27, 27),
                        Color.fromARGB(255, 48, 47, 47),
                        Color.fromARGB(255, 55, 55, 55),
                      ],
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Men\'s Fashion Collections',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Text(
                              'Discount up to 60%',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Image.asset(
                          'assets/image_4.png',
                          width: 146,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: 50,
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
  Widget build(Object context, double shrinkOffset, bool overlapsContent) {
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
