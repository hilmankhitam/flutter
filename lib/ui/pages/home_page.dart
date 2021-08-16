part of 'pages.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  late int bottomNavBarIndex;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: accentColor1),
        SafeArea(child: Container(color: mainColor)),
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            bottomNavBarIndex = index;
          },
          children: const <Widget>[
            RestaurantPage(),
            SettingPage(),
          ],
        ),
        buttomNavBar(),
      ],
    ));
  }

  Widget buttomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: accentColor1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: accentColor3,
          unselectedItemColor: mainColor,
          currentIndex: bottomNavBarIndex,
          selectedLabelStyle: whiteTextFont.copyWith(fontSize: 16),
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Restaurants',
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(
                  Icons.settings_accessibility,
                )),
          ],
        ),
      ),
    );
  }
}
