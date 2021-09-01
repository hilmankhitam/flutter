part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnHomePage)
          ? HomePage(bottomNavBarIndex: pageState.bottomNavBarIndex)
          : (pageState is OnRestaurantDetailPage)
              ? RestaurantDetailPage(pageState.restaurant, pageState.userName)
              : (pageState is OnSearchPage)
                  ? SearchPage(pageState.userName)
                  : const SplashScreen(),
    );
  }
}
