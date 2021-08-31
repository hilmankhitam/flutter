part of 'pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage(this.userName, {Key? key}) : super(key: key);
  final String userName;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool _isScheduled = false;
  @override
  void initState() {
    super.initState();

    getReminder();
  }

  Future<void> getReminder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() => _isScheduled = prefs.getBool('showReminder') ?? false);
  }

  Future<bool> setReminder(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool('showReminder', value);
  }

  Future<bool?> scheduledRestaurant(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      debugPrint('Notification has been Scheduled');
      NotificationHelper.showScheduleNotification();
      setReminder(value);
      Flushbar(
              duration: const Duration(milliseconds: 3000),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: accentColor1,
              message: "Notification has been Scheduled")
          .show(context);
      return prefs.getBool('showReminder');
    } else {
      debugPrint('notification has been canceled');
      NotificationHelper.cancel();
      setReminder(value);
      Flushbar(
              duration: const Duration(milliseconds: 3000),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: accentColor1,
              message: "Notification has been Canceled")
          .show(context);
      return prefs.getBool('showReminder');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Text(widget.userName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: blackTextFont.copyWith(fontSize: 18)),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              child: ListTile(
                  title: const Text('Scheduling Notification'),
                  trailing: Switch(
                      value: _isScheduled,
                      onChanged: (value) async {
                        scheduledRestaurant(value);
                        setState(() {
                          _isScheduled = value;
                        });
                      })),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55,
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5),
                    ),
                    elevation: 0,
                    primary: accentColor3,
                  ),
                  onPressed: () {
                    defaultTargetPlatform != TargetPlatform.iOS
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Coming Soon!'),
                                content: const Text(
                                    'This feature will be coming soon!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          )
                        : showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('Coming Soon!'),
                                content: const Text(
                                    'This feature will be coming soon!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                  },
                  child: Text(
                    "Log out",
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    ]);
  }
}
