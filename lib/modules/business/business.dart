import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/components/components/components.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context, state) {},
     builder: (context, state) {

       dynamic tasks=NewsCubit.get(context).business;
      return buildArticlesScreen(tasks,isSearch: false);
     }

   );
  }
}
