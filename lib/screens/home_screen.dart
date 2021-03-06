import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkpoint3/models/Transactions.dart';
import 'package:checkpoint3/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint3/screens/home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("TXNNXT's Form"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey[50],
                          radius: 30,
                          child: FittedBox(
                            child: Text(data.title.toString()),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle: Text(data.address),
                        trailing: Icon(Icons.more_vert),
                      ),
                    );
                  });
            }
          },
        ));
  }
}