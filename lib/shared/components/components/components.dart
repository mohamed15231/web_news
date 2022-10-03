import 'dart:js';

import 'package:flutter/material.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/modules/web_view/web_view.dart';
import 'package:responsive_builder/responsive_builder.dart';


Widget buildArticlesScreen(dynamic tasks,{required BuildContext context,bool isSearch = false}) {
  return tasks == null
      ? isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            )
      : ScreenTypeLayout(
          mobile: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenWebView(url: tasks[index]["url"]),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              onError: (exception, stackTrace) => const Text(
                                "Image here ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black),
                              ),
                              image: NetworkImage(
                                "${tasks[index]["urlToImage"]}",
                              ),
                            )),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 120.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${tasks[index]["title"]} ",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Text(
                                    "${tasks[index]["publishedAt"]} ",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
              itemCount: tasks.length),
          desktop: webView(tasks,context: context, isSearch: isSearch),
    breakpoints: const ScreenBreakpoints(
      desktop: 850,
      tablet: 300,
      watch: 300
    ),
        );
}

Widget webView(dynamic tasks, {required BuildContext context,bool isSearch = false}) {
  return Row(
    children: [
      Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           ScreenWebView(url: tasks[index]["url"]),
                    //     ));
                    NewsCubit.get(context).changeIndexDescription(index);
                  },
                  child: Container(
                    color:  NewsCubit.get(context).currentIndexDescription==index?Colors.grey:null,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              onError: (exception, stackTrace) => const Text(
                                "Image here ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black),
                              ),
                              image: NetworkImage(
                                "${tasks[index]["urlToImage"]}",
                              ),
                            )),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 120.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${tasks[index]["title"]} ",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Text(
                                    "${tasks[index]["publishedAt"]} ",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
            itemCount: tasks.length),
      ),
      Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
        color: Colors.grey,
            child: Text(tasks[NewsCubit.get(context).currentIndexDescription]['description'],
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),),
          ))
    ],
  );
}
