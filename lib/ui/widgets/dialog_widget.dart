part of 'widgets.dart';

class ShowDialog extends StatefulWidget {
  final String id;
  final String name;
  const ShowDialog(this.id, this.name, {Key? key}) : super(key: key);

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 330,
        height: 200,
        decoration: const BoxDecoration(
          color: mainColor,
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: reviewController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Review',
                hintText: 'Review',
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  primary: accentColor1,
                ),
                onPressed: () {
                  if (reviewController.text != '') {
                    RestaurantServices.addReview(
                        widget.id, widget.name, reviewController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add Review",
                  style: whiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ),
        ]),
      ),
    );
  }
}
