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
          List<Restaurant> restaurants =
              restaurantState.restaurants.restaurants.sublist(10);
          return Column(
              children: restaurants
                  .map((e) => RestaurantList(e, onTap: () {
                        context
                            .read<PageBloc>()
                            .add(GoToRestaurantDetailPage(e, nameUser));
                      }))
                  .toList());
        } else {
          return const Center(child: Text('Some Error Occured'));
        }
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
            List<Restaurant> restaurants =
                restaurantState.restaurants.restaurants.sublist(0, 10);
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
                          context.read<PageBloc>().add(
                              GoToRestaurantDetailPage(restaurants[index], nameUser));
                        },
                      ),
                    ));
          } else {
            return const Center(child: Text('Some Error Occured'));
          }
        } else {
          return const SpinKitFadingCircle(color: accentColor1, size: 50);
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
