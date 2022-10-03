import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/business/business.dart';
import 'package:newsapp/modules/science/science.dart';
import 'package:newsapp/modules/settings/settings.dart';
import 'package:newsapp/modules/sport/sports.dart';
import 'package:sqflite/sqflite.dart';
import '../../shared/components/constants/constants.dart';
import '../../shared/network/remote/api.dart';
import '../../shared/network/remote/shared_preferences.dart';

//https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=de96ffc248554e549393921bb0fb49ee

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  dynamic business;
  dynamic sports;
  dynamic sciences;
  dynamic search;

  // late bool isDark1;

  int currentIndex = 0;
  int currentIndexDescription = 1;

  void changeIndexDescription(int index){
    currentIndexDescription=index;
    emit(ChangeNewsDescriptionStates());
  }
  List<BottomNavigationBarItem> bottomNavigator = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: "Business"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: "Science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  List screens = [
    const Business(),
    const Sports(),
    const Science(),
    const Settings()
  ];
  late Database database;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(currentIndex==1) {
      getSportsData( country: isEg!? "eg":"us");
    } else if(currentIndex==2) {
      getSciencesData(country: isEg!? "eg":"us");
    }

    emit(ChangeBottomNavBarStates());
  }

  void getBusinessData({
  required String country
}){
    emit(GetBusinessDataLoading());
    DioApp.getDio(
      path: "v2/top-headlines",
      query: {
        "country": "$country",
        "category":"business",
        "apiKey":"71c234d1c21d4ceea60b49f09e8c933d",
      },
    ).then((value) {
      business=value.data["articles"];

      emit(GetBusinessDataSuccessful());
    }).catchError((error){
      emit(
          GetBusinessDataError(error: error)
      );
    });
  }

  void getSportsData({
    required String country
  }){
    emit(GetSportsDataLoading());
    DioApp.getDio(
      path: "v2/top-headlines",
      query: {
        "country": country,
        "category":"sports",
        "apiKey":"71c234d1c21d4ceea60b49f09e8c933d",
      },
    ).then((value) {
      sports=value.data["articles"];

      emit(GetSportsDataSuccessful());
    }).catchError((error){
      emit(
          GetSportsDataError(error: error)
      );
    });
  }


  bool? changeLight;
  Color onTapColor=Colors.blue;


  void changeColor({
  required bool value
}){
    isEg=value;
    emit(ChangeColorStates());
  }

  void changeSwitchValue({
  bool? isShared
}){
    if(isShared!=null){
      changeLight=isShared;
      emit(ChangeSwitchStates());

    }else{
      changeLight=!changeLight!;
      SaveData.setData(key: "isdark", value: changeLight!);
      emit(ChangeSwitchStates());
    }



  }
  void getSciencesData({
  required String country
}){
    emit(GetSciencesDataLoading());
    DioApp.getDio(
      path: "v2/top-headlines",
      query: {
        "country": country,
        "category":"science",
        "apiKey":"71c234d1c21d4ceea60b49f09e8c933d",
      },
    ).then((value) {
      sciences=value.data["articles"];
      emit(GetSciencesDataSuccessful());
    }).catchError((error){
      emit(
          GetSciencesDataError(error: error)
      );
    });
  }


  void getSearchData({
    required  String value
  }){
    emit(GetSearchDataLoading());
    DioApp.getDio(
      path: "v2/everything",
      query: {
        "q":"$value",
        "apiKey":"71c234d1c21d4ceea60b49f09e8c933d",
      },
    ).then((value) {
      search=value.data["articles"];

      emit(GetSearchDataSuccessful());
    }).catchError((error){
      emit(
          GetSearchDataError(error: error)
      );
    });
  }




}
