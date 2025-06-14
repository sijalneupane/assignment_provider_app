import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/features/assignment/view/get_assignment.dart';
import 'package:provider_test1/features/home/provider/splash_screen_provider.dart';
import 'package:provider_test1/features/home/provider/theme_provider.dart';
import 'package:provider_test1/features/home/view/bottom_navbar1.dart';
import 'package:provider_test1/features/home/view/home1.dart';
import 'package:provider_test1/features/home/view/splash_screen.dart';
import 'package:provider_test1/features/home/view/splash_screen_theme_change_demo.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/features/login/view/login1.dart';
import 'package:provider_test1/features/notices/provider/notices_provider.dart';
import 'package:provider_test1/features/notices/view/add_notice.dart';
import 'package:provider_test1/features/notices/view/add_notice2.dart';
import 'package:provider_test1/firebase_options.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/search_POS.dart';
import 'package:provider_test1/utils/snackbar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = 
      GlobalKey<ScaffoldMessengerState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> firebaseNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();


class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel channel;
  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    requestNotificationPermissions();
    initNotifications();
    configureFirebaseMessaging();
    checkForInitialMessage(); // ✅ handles notification tap when app is terminated
  }

  Future<void> initNotifications() async {
    // Create the Android notification channel
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Initialize native Android and iOS notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Using default Flutter icon name

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // ✅ handles local notification tap
        firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
      },
    );
  }

  Future<void> requestNotificationPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // For both Android & iOS
    final status = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${status.authorizationStatus}');
  }

  void configureFirebaseMessaging() {
    // For foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (notification != null) {
        print('Message also contained a notification: ${notification.title}');

        try {
          // Show the notification in the foreground
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                // Use default Flutter app icon
                icon: '@mipmap/ic_launcher',
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
          );
          print('Successfully displayed notification');
        } catch (e) {
          print('Error showing notification: $e');
        }
      }
    });

    // For notifications opened while app is in background (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A notification was opened from the background state!');
      // ✅ Navigate to notification screen when notification is tapped from background
      firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
    });
  }

  void initializeFirebaseMessaging() async {
    try {
      // Get FCM token
    String? token = await messaging.getToken();
    print("FCM TOKEN: $token");

    // Subscribe to topics if needed
    // await FirebaseMessaging.instance.subscribeToTopic('general');
    } catch (e) {
      print(e.toString()); }
  }

  // ✅ Check for notification tap when app is terminated
  Future<void> checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print('App was launched by clicking on a notification!');
      firebaseNavigatorKey.currentState?.pushNamed(Routes.notificationRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) =>  MultiProvider(
          providers: [
            // ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (_) => AssignmentProvider()),
            ChangeNotifierProvider(create: (_)=>NoticesProvider()),
            ChangeNotifierProvider(create: (_)=>SplashScreenProvider()),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Assignment Management App',themeMode: themeProvider.themeMode,
            
            // theme: ThemeData(
            //   brightness: Brightness.light,
            //   primarySwatch: Colors.blue,
            //   appBarTheme: AppBarTheme(
            //     backgroundColor: Colors.blue,
            //     foregroundColor: Colors.white,
            //   ),
            // ),
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark,
            //   primarySwatch: Colors.blue,
            //   appBarTheme: AppBarTheme(
            //     backgroundColor: Colors.grey[900],
            //     foregroundColor: Colors.white,
            //   ),
            // ),
            
            
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,surface:Colors.white ),
              // buttonTheme: ButtonThemeData(
              //   buttonColor: Colors.white,
              // )
            ),
            // home: AddNotice2(),
            home: SplashScreen(),
            // home: AddNoticeForm(),
            // home: BottomNavbar1(),
            // home:Home1(),

            // home:SearchBarExample()
          ),
        ),
      ),
    );
  }
}
