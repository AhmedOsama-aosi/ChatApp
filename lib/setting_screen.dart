import 'package:flutter/material.dart';

import 'shared.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("ah os")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[400],
                  ),
                ),
                Align(
                    heightFactor: 1.8,
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: primarycolor.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                            spreadRadius: 2),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Acount",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ah@gh.com",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ah os",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "bio",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "hey i am using chat room",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: primarycolor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: primarycolor.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                              spreadRadius: 5),
                        ],
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                            highlightColor: Colors.blue[800],
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: primarycolor.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                          spreadRadius: 2),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(Icons.settings),
                              title: Text("setting"),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(Icons.color_lens_rounded),
                              title: Text("colors"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
