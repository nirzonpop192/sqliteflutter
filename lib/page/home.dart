import 'package:flutter/material.dart';
import '../model/client.dart';
import '../db/db_provider.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  List<Client> testClients = [
    Client(firstName: "Faisal", lastName: "Mohammad"),
    Client(firstName: "Nayon", lastName: "Talu"),
    Client(firstName: "Fayz", lastName: "Talu"),
    Client(firstName: "Ismail", lastName: "pop"),
    Client(firstName: "Palash", lastName: "pop"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLIte"),
      ),
      body: FutureBuilder<List<Client>>(
        future: DB_Provider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return
              ListView.builder(
                  scrollDirection:Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Client row = snapshot.data[index];

                return   Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      DB_Provider.db.deleteClient(row.id);
                      setState(() {});
                    },
                    child: ListTile(
                      title: Text("${row.firstName} ${row.lastName}"),
                      leading: (Text(row.id.toString())),
                    ),
                  );
                });
          }
          else return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Client rnd = testClients[math.Random().nextInt(testClients.length)];
          await DB_Provider.db.newClient(rnd);
          setState(() {});
        },
      ),
    );
  }
}
