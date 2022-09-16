import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' show Client;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {}
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantsResult restaurants) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "dicoding restaurants channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // get restaurant list
    RestaurantRepository restaurantRepository = RestaurantRepository();
    var restaurantResult = await restaurantRepository.getRestaurants(Client());
    var restaurants = restaurantResult.restaurants;

    // get random restaurant from list of restaurant
    var randomIndex = Random().nextInt(restaurants.length);
    var randomRestaurant = restaurants[randomIndex];

    var titleNotification = "<b>Notifikasi Restoran</b>";
    var titleRestaurants = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurants,
      platformChannelSpecifics,
      payload: json.encode(
        randomRestaurant.toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, data);
      },
    );
  }
}
