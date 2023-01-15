import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../constants.dart';

class ListRequests extends StatefulWidget {
  @override
  State<ListRequests> createState() => _ListRequestsState();
}

class _ListRequestsState extends State<ListRequests> {
  @override
  Widget build(BuildContext context) {
    final firmList = FirebaseFirestore.instance.collection("firms").get();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        FutureBuilder<QuerySnapshot>(
          future: firmList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final arrData = snapshot.data!.docs;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.80,
                    width: width * 0.88,
                    child: Container(
                      child: ListView(
                        children: arrData.map((data) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kSecondary,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kShadowColor.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: width * 0.82,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: height / 100),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '/' + data['max_value'].toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
              //return Text("data found");
            } else {
              return Text("data not found");
            }
          },
        ),
      ],
    );
  }
}
