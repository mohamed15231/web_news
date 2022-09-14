import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/components/constants/constants.dart';
import 'package:newsapp/shared/network/remote/shared_preferences.dart';

import '../../shared/components/constants/constants.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Dark mode",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Switch(
                      value:NewsCubit.get(context).changeLight!,
                      onChanged: (value) {

                        NewsCubit.get(context).changeSwitchValue();

                      }),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Country",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: isEg??true
                          ? MaterialStateProperty.all(Colors.blue)
                          : MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                    ),
                    onPressed: () {
                      NewsCubit.get(context).changeColor(value: true);
                      NewsCubit.get(context).getBusinessData(country: "eg");
                      SaveData.setData(key: "isEg", value: true);
                    },
                    child: const Text(
                      "EG",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:(isEg??true)
                          ?MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor)
                          : MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {

                      NewsCubit.get(context).changeColor(value: false);
                      NewsCubit.get(context).getBusinessData(country: "us");
                      SaveData.setData(key: "isEg", value: false);
                    },
                    child: const Text(
                      "US",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
