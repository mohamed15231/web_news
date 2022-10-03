import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/layout/homenewsapp.dart';
import 'package:newsapp/shared/components/constants/constants.dart';
import 'package:newsapp/shared/network/local/bloc_observer.dart';
import 'package:newsapp/shared/network/remote/api.dart';
import 'package:newsapp/shared/network/remote/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SaveData.init();
   isEg=SaveData.getData(key: "isEg")??true;
   print(isEg);
  bool? isdark=SaveData.getData(key: "isdark")??false;
  usePathUrlStrategy();

  DioApp.initialDio();
    BlocOverrides.runZoned(
          () {
            runApp( MyApp(isdark: isdark,isEg: isEg??true,));
      },
      blocObserver: MyBlocObserver(),
    );
  }




class MyApp extends StatelessWidget{
   MyApp({Key? key,required this.isEg, required this.isdark}) : super(key: key);
  bool isEg;
  bool isdark;
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>NewsCubit()..getBusinessData(country: isEg?"eg":"us")..changeSwitchValue(isShared: isdark),
     child: BlocConsumer<NewsCubit,NewsStates>(
       listener: (context, state) {},
       builder: (context, state) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
               textTheme:const TextTheme(
                 bodyText1: (
                     TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                       color: Colors.black,
                     )
                 ),
               ) ,
               primarySwatch: Colors.deepOrange,
               scaffoldBackgroundColor: Colors.white,
               appBarTheme: const AppBarTheme(
                 titleSpacing: 20.0,
                 actionsIconTheme: IconThemeData(
                     color: Colors.black
                 ),
                 titleTextStyle: TextStyle(
                     color: Colors.black,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold
                 ),
                 systemOverlayStyle: SystemUiOverlayStyle(
                   statusBarColor: Colors.white,
                   statusBarIconBrightness: Brightness.dark,
                 ),
                 color: Colors.white,
                 elevation: 0.0,
               ),
               bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                   elevation: 20.0,
                   selectedIconTheme: IconThemeData(
                       color: Colors.deepOrange
                   )
               )

           ),
           darkTheme: ThemeData(
               textTheme:const TextTheme(
                 bodyText1: (
                     TextStyle(
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                         color: Colors.white
                     )
                 ),
               ) ,
               primarySwatch: Colors.deepOrange,
               scaffoldBackgroundColor: HexColor("333739"),
               appBarTheme:  AppBarTheme(
                 titleSpacing: 20.0,
                 actionsIconTheme:const IconThemeData(
                   color:  Colors.white,
                 ),
                 titleTextStyle: const TextStyle(
                     color: Colors.white,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold
                 ),
                 systemOverlayStyle: SystemUiOverlayStyle(
                   statusBarColor:  HexColor("333739"),
                   statusBarIconBrightness: Brightness.light,
                 ),
                 color:  HexColor("333739"),
                 elevation: 0.0,
               ),
               bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                 elevation: 20.0,
                 selectedIconTheme: const IconThemeData(
                     color: Colors.deepOrange
                 ),
                 unselectedIconTheme: const IconThemeData(
                     color: Colors.grey
                 ),
                 backgroundColor: HexColor("333739"),
               )

           ),
           themeMode:NewsCubit.get(context).changeLight! ? ThemeMode.dark:ThemeMode.light ,
           home: const HomeNewsApp(),
         );
       },

     ),
   );
  }

}