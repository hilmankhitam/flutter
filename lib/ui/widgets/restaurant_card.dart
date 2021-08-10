part of 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function onTap;

  const RestaurantCard(this.restaurant, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            width: 230,
            height: 220,
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: SizedBox(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: accentColor3,
                            size: 20,
                          ),
                          const SizedBox(width: 2),
                          Text(restaurant.rating.toString(),
                              style: greyTextFont)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Hero(
              tag: restaurant.pictureId,
              child: Container(
                height: 140,
                width: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.pictureId),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
