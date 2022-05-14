import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '/config/config.dart';
import '/repositories/set/set_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'repositories/account/account_repository.dart';
import 'repositories/auth/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyAog5tvJGNb63Hjbe6TpPVPW_Qp_D9iKRs',
    //     appId: '1:526121573343:web:b0caef970924f065c6c26a',
    //     messagingSenderId: '526121573343',
    //     projectId: 'viewyourstories-4bf4d',
    //     storageBucket: 'viewyourstories-4bf4d.appspot.com',
    //   ),
    // );
  } else {
    await Firebase.initializeApp();
  }

  // Get any  initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  print('Firebase dynamic initial link $initialLink');
  //await SharedPrefs().init();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());

  runApp(MyApp(
    initialLink: initialLink,
  ));
}

class MyApp extends StatelessWidget {
  final PendingDynamicLinkData? initialLink;

  const MyApp({Key? key, required this.initialLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

          /// systemNavigationBarColor: Colors.blue, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark // status bar color
          ),
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<AccountRepository>(
          create: (_) => AccountRepository(),
        ),
        RepositoryProvider<SetRepository>(
          create: (_) => SetRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          //showPerformanceOverlay: true,
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Colors.green,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
            fontFamily: 'TitilliumWeb',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          //   home: Swipping(title: 'Title'),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
          onGenerateInitialRoutes: (_) {
            return [
              AuthWrapper.route(args: AuthWrapperArgs(initialLink: initialLink))
            ];
          },
        ),
      ),
    );
  }
}
