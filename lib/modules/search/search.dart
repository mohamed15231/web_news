import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/components/components/components.dart';

class SearchScrean extends StatelessWidget {
  const SearchScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic lists = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Search",

                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "search must not empty";
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearchData(value: value);
                  },
                ),
              ),
              Expanded(child: buildArticlesScreen(lists,context: context,isSearch: true,)),
            ],
          ),
        );
      },
    );
  }
}
