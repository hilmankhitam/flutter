part of 'widgets.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;
  final Function onTap;

  const RestaurantList(this.restaurant, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width - 2 * defaultMargin,
          height: 100,
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Container(
                  height: 80,
                  width: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(restaurant.pictureId),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    2 * 10 -
                    105 -
                    10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextFont.copyWith(fontSize: 16)),
                    Text(restaurant.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: greyTextFont.copyWith(fontSize: 10)),
                    const SizedBox(
                      height: 3,
                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
