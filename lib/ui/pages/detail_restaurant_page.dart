part of 'pages.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_restaurant_page';
  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(child: Container(color: mainColor)),
          ListView(
            children: [
              header(context),
              picture(),
              content(),
            ],
          ),
        ],
      ),
    );
  }

  Hero picture() {
    return Hero(
      tag: restaurant.pictureId,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        height: 300,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(restaurant.pictureId),
                    fit: BoxFit.cover))),
      ),
    );
  }

  Container header(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.04),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: accentColor1),
            ),
          ),
          Text('Details',
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.04),
            ),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.settings, color: accentColor1),
            ),
          ),
        ],
      ),
    );
  }

  Container content() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name,
                    style: blackTextFont.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: accentColor3,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(restaurant.city, style: greyTextFont)
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: accentColor3,
                  size: 20,
                ),
                const SizedBox(width: 2),
                Text(restaurant.rating.toString(), style: greyTextFont)
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(restaurant.description,
            textAlign: TextAlign.justify, style: greyTextFont),
        const SizedBox(height: 8),
        Text('Foods', style: blackTextFont.copyWith(fontSize: 18)),
        listFoods(),
        const SizedBox(height: 8),
        Text('Drinks', style: blackTextFont.copyWith(fontSize: 18)),
        listDrinks(),
        const SizedBox(height: 20),
      ]),
    );
  }

  SingleChildScrollView listDrinks() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.drinks
            .map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/drink.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 70,
                        height: 40,
                        child: Text(e.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: blackTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w400))),
                  ],
                )))
            .toList(),
      ),
    );
  }

  SingleChildScrollView listFoods() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.foods
            .map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/food.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 70,
                        height: 40,
                        child: Text(e.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: blackTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w400))),
                  ],
                )))
            .toList(),
      ),
    );
  }
}
