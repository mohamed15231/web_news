import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';

import '../../shared/components/components/components.dart';

class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          dynamic tasks = NewsCubit
              .get(context)
              .sports;

          return ConditionalBuilderRec(condition: tasks != null,
            builder: (context) => buildArticlesScreen(tasks,context: context, isSearch: false,),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

    );
  }
}

