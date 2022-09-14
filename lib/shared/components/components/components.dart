import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/web_view.dart';

Widget buildArticlesScreen(dynamic tasks, { bool isSearch=false}) {
  return tasks == null
      ? isSearch?Container() : const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.separated(
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
                                  style: Theme.of(context).textTheme.bodyText1,
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
          itemCount: tasks.length);
}
