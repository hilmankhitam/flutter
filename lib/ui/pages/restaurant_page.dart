part of 'pages.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage(this.userName,{Key? key}) : super(key: key);
  final String userName;

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

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
              Text('Top Restaurants',
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              Text('See More', style: yellowTextFont),
            ],
          ),
        ),
        restaurantCard(),
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
        restaurantList(),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  BlocBuilder<RestaurantBloc, RestaurantState> restaurantList() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (_, restaurantState) {
      if (restaurantState is RestaurantLoaded) {
        if (restaurantState.restaurants.error == false) {
          var sortedRestaurants = restaurantState.restaurants.restaurants;
            sortedRestaurants.sort((restaurant1, restaurant2) =>
                restaurant2.rating.compareTo(restaurant1.rating));
          List<Restaurant> restaurants = sortedRestaurants.sublist(10);
          return Column(
              children: restaurants
                  .map((e) => RestaurantList(e, onTap: () {
                        context
                            .read<PageBloc>()
                            .add(GoToRestaurantDetailPage(e, widget.userName));
                      }))
                  .toList());
        } else {
          return const Center(child: Text('Some Error Occured'));
        }
      } else if (restaurantState is RestaurantError) {
        return Center(child: Text(restaurantState.error));
      } else {
        return const SpinKitFadingCircle(color: accentColor1, size: 50);
      }
    });
  }

  Widget restaurantCard() {
    return SizedBox(
      height: 220,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (_, restaurantState) {
        if (restaurantState is RestaurantLoaded) {
          if (restaurantState.restaurants.error == false) {
            var sortedRestaurants = restaurantState.restaurants.restaurants;
            sortedRestaurants.sort((restaurant1, restaurant2) =>
                restaurant2.rating.compareTo(restaurant1.rating));
            List<Restaurant> restaurants = sortedRestaurants.sublist(0, 10);
            return ListView.builder(
                itemCount: restaurants.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          right: (index == restaurants.length - 1)
                              ? defaultMargin
                              : 16,
                          left: (index == 0) ? defaultMargin : 0),
                      child: RestaurantCard(
                        restaurants[index],
                        onTap: () {
                          context.read<PageBloc>().add(GoToRestaurantDetailPage(
                              restaurants[index], widget.userName));
                        },
                      ),
                    ));
          } else {
            return const Center(child: Text('Some Error Occured'));
          }
        } else if (restaurantState is RestaurantError) {
          return Center(child: Text(restaurantState.error));
        } else {
          return const SpinKitFadingCircle(color: accentColor1, size: 50);
        }
      }),
    );
  }

  Widget header(BuildContext context) {
    DateTime sekarang = DateTime.now();
    String message;
    if (sekarang.hour < 12) {
      message = 'Good Moring,';
    } else if (sekarang.hour < 15) {
      message = 'Good Afternoon,';
    } else if (sekarang.hour < 20) {
      message = 'Good Evening,';
    } else {
      message = 'Good Night,';
    }
    return Column(
      children: [
        Container(
          height: 50,
          margin: EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 0),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('What would you like to eat today?', style: whiteTextFont),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(GoToSearchPage(widget.userName));
                },
                child: const Icon(Icons.search, color: mainColor)),
          ]),
        ),
        Container(
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
                      child: Text(message,
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
                      child: Text(widget.userName,
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
        ),
      ],
    );
  }
}
