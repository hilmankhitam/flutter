part of 'pages.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  String nameUser = 'Hilman Khitam';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        header(context),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Restaurant',
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              Text('See More', style: yellowTextFont),
            ],
          ),
        ),
        restaurantCard(context),
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('On Promotion',
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              Text('See More', style: yellowTextFont),
            ],
          ),
        ),
        restaurantList(context),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  FutureBuilder<List<Restaurant>> restaurantList(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
        future: RestaurantServices.getRestaurant(context),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                  child: SpinKitFadingCircle(
                color: accentColor1,
                size: 50,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text('Some ERROR Occurred',
                        style: blackTextFont.copyWith(fontSize: 20)));
              } else {
                List<Restaurant>? restaurant = snapshot.data!.sublist(5, 10);
                var sortedRestaurant = restaurant;
                sortedRestaurant.sort((restaurant1, restaurant2) =>
                    restaurant2.rating.compareTo(restaurant1.rating));
                return Column(
                  children: sortedRestaurant
                      .map((e) => RestaurantList(e, onTap: () {
                            Navigator.pushNamed(
                                context, RestaurantDetailPage.routeName,
                                arguments: e);
                          }))
                      .toList(),
                );
              }
          }
        });
  }

  Widget restaurantCard(BuildContext context) {
    return SizedBox(
      height: 220,
      child: FutureBuilder<List<Restaurant>>(
          future: RestaurantServices.getRestaurant(context),
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: SpinKitFadingCircle(
                  color: accentColor1,
                  size: 50,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Some ERROR Occurred',
                          style: blackTextFont.copyWith(fontSize: 20)));
                } else {
                  List<Restaurant>? restaurant = snapshot.data!.sublist(0, 5);
                  var sortedRestaurant = restaurant;
                  sortedRestaurant.sort((restaurant1, restaurant2) =>
                      restaurant2.rating.compareTo(restaurant1.rating));
                  return ListView.builder(
                    itemCount: sortedRestaurant.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == restaurant.length - 1)
                              ? defaultMargin
                              : 16),
                      child: RestaurantCard(sortedRestaurant[index], onTap: () {
                        Navigator.pushNamed(
                            context, RestaurantDetailPage.routeName,
                            arguments: sortedRestaurant[index]);
                      }),
                    ),
                  );
                }
            }
          }),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 0),
      decoration: BoxDecoration(
        color: accentColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      2 * defaultMargin -
                      50 -
                      18 -
                      2 * 14,
                  child: Text('Hello, $nameUser',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: whiteTextFont.copyWith(fontSize: 18)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      2 * defaultMargin -
                      50 -
                      18 -
                      2 * 14,
                  child: Text('What would you like to eat today?',
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: greyTextFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
