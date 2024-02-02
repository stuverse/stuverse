import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class HorzTabItem {
  final String title;
  final int id;

  HorzTabItem({required this.title, required this.id});
}

List<HorzTabItem> categoryList = [
  HorzTabItem(title: "All", id: 0),
  HorzTabItem(title: "Mentor", id: 1),
  HorzTabItem(title: "Job", id: 2),
  HorzTabItem(title: "Fund", id: 3),
  HorzTabItem(title: "Event", id: 4),
  HorzTabItem(title: "Community", id: 5),
  HorzTabItem(title: "Project", id: 6),
  HorzTabItem(title: "Course", id: 7),
  HorzTabItem(title: "Internship", id: 8),
  HorzTabItem(title: "Scholarship", id: 9),
  HorzTabItem(title: "Contest", id: 10),
  HorzTabItem(title: "Hackathon", id: 11),
  HorzTabItem(title: "Competition", id: 12),
  HorzTabItem(title: "Conference", id: 13),
  HorzTabItem(title: "Seminar", id: 14),
  HorzTabItem(title: "Workshop", id: 15),
  HorzTabItem(title: "Webinar", id: 16),
  HorzTabItem(title: "Meetup", id: 17),
  HorzTabItem(title: "Summit", id: 18),
  HorzTabItem(title: "Festival", id: 19),
  HorzTabItem(title: "Expo", id: 20),
  HorzTabItem(title: "Fair", id: 21),
  HorzTabItem(title: "Show", id: 22),
  HorzTabItem(title: "Exhibition", id: 23),
  HorzTabItem(title: "Tour", id: 24),
  HorzTabItem(title: "Carnival", id: 25),
  HorzTabItem(title: "Rally", id: 26),
  HorzTabItem(title: "Parade", id: 27),
  HorzTabItem(title: "Fiesta", id: 28),
  HorzTabItem(title: "Ceremony", id: 29),
  HorzTabItem(title: "Gala", id: 30),
];

class HorzTabBar extends StatelessWidget {
  const HorzTabBar(
      {Key? key,
      required this.categoryList,
      required this.onSelected,
      required this.selectedCategory})
      : super(key: key);
  final List<HorzTabItem> categoryList;
  final Function(HorzTabItem) onSelected;
  final HorzTabItem selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return HorzTabCard(
            category: categoryList[index],
            isSelected: selectedCategory.id == categoryList[index].id,
            onPressed: () {
              onSelected(categoryList[index]);
            },
          );
        },
      ),
    );
  }
}

class HorzTabCard extends StatefulWidget {
  final HorzTabItem category;
  final bool isSelected;
  final Function() onPressed;

  const HorzTabCard(
      {required this.category,
      required this.onPressed,
      Key? key,
      required this.isSelected})
      : super(key: key);

  @override
  State<HorzTabCard> createState() => _HorzTabCardState();
}

class _HorzTabCardState extends State<HorzTabCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
              color: widget.isSelected
                  ? context.colorScheme.secondaryContainer
                  : Colors.transparent),
          color: widget.isSelected
              ? context.colorScheme.secondaryContainer
              : Colors.transparent),
      child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            widget.onPressed();
          },
          child: Text(widget.category.title,
              style: TextStyle(
                  color: widget.isSelected ? Colors.black : Colors.grey))),
    );
  }
}

class TabPair {
  final Tab tab;
  final Widget view;
  TabPair({required this.tab, required this.view});
}

List<TabPair> TabPairs = [
  TabPair(
    tab: Tab(
      text: 'Intro',
    ),
    view: Center(
      child: Text(
        'Intro here',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  TabPair(
    tab: Tab(
      text: 'Ingredients',
    ),
    view: Center(
      // replace with your own widget here
      child: Text(
        'Ingredients here',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  TabPair(
    tab: Tab(
      text: 'Steps',
    ),
    view: Center(
      child: Text(
        'Steps here',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  )
];

class TabBarAndTabViews extends StatefulWidget {
  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: TabPairs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change height to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Color(0xFFFF8527),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: TabPairs.map((tabPair) => tabPair.tab).toList()),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: TabPairs.map((tabPair) => tabPair.view).toList()),
          ),
        ],
      ),
    );
  }
}
