part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnSplashPage)
          ? const SplashScreen()
          : (pageState is OnRestaurantDetailPage)
              ? RestaurantDetailPage(pageState.restaurant, pageState.userName)
              : const HomePage(),
    );
  }
}
