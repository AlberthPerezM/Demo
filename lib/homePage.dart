import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'PhotoUpload.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final blog = db.collection("blog");

    /* final doc = db.doc("/blog/HmYn8DM6LYdwsHb3Yom9");*/
    return Scaffold(
      appBar: AppBar(
        /*Logo */
        title: Image.asset(
          'assets/paku.png',
          fit: BoxFit.cover,
          height: 50,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          /*Nuestro blog */
          Container(
            child: Text(
              "Nuestro blog",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            width: 500,
            height: 50,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: blog.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              /**ListView ListBluider */
              final docsnap = snapshot.data!;
              return Column(
                children: [
                  /*Image(
                    image: NetworkImage('assets/paku.png'),
                    height: 140,
                  ),*/
                  //Imagen

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      docsnap.docs[1]['image'],
                      width: 500,
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //titulo
                      Text(
                        docsnap.docs[1]['title'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      //fecha
                      Text(getTime((docsnap.docs[1]['date'] as Timestamp))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //contenido
                  Text(docsnap.docs[1]['summary']),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: GestureDetector(
                        child: Text(
                          "Click here",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                        onTap: () {
                          // do what you need to do when "Click here" gets clicked
                        }),
                    width: 500,
                  ),
                ],
              );
            },
          ),
        ],
      )),

      /*Boton con icono de imagen*/
      /*  bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 3, 36, 62),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PhotoUpload();
                    }));
                  },
                )
              ],
            ),
          ),
        )*/
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 3, 10, 43),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }

  /*String getFormatfromDate(Timestamp time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time.microsecondsSinceEpoch);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }*/

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }
}
