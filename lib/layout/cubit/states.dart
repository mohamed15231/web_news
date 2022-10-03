import 'package:newsapp/layout/cubit/cubit.dart';

abstract class NewsStates {}

class InitialStates extends NewsStates{}

class ChangeBottomNavBarStates extends NewsStates{}

class ChangeNewsDescriptionStates extends NewsStates{}

class ChangeSwitchStates extends NewsStates{}

class ChangeColorStates extends NewsStates{}

class GetBusinessDataLoading extends NewsStates{}

class GetBusinessDataSuccessful extends NewsStates{}

class GetBusinessDataError extends NewsStates{
  final error;

  GetBusinessDataError({
    required this.error
}){
    print(error);
  }


}

class GetSportsDataLoading extends NewsStates{}

class GetSportsDataSuccessful extends NewsStates{}

class GetSportsDataError extends NewsStates{
  final error;

  GetSportsDataError({
    required this.error
  }){
    print(error);
  }


}

class GetSciencesDataLoading extends NewsStates{}

class GetSciencesDataSuccessful extends NewsStates{}

class GetSciencesDataError extends NewsStates{
  final error;

  GetSciencesDataError({
    required this.error
  }){
    print(error);
  }


}

class CreateDataBase extends NewsStates{}

class InsertDataBase extends NewsStates{}

class ChangeLightnessState extends NewsStates{}

class GetDataBase extends NewsStates{}

class UpdateDataBase extends NewsStates{}

class GetSearchDataLoading extends NewsStates{}

class GetSearchDataSuccessful extends NewsStates{}

class GetSearchDataError extends NewsStates{
  final error;

  GetSearchDataError({
    required this.error
  }){
    print(error);
  }


}