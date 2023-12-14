import 'package:flutter/material.dart';
import 'package:submission_first_flutter_fundamental/detail_screens.dart';

class Restaurant {
  final String Title;

  Restaurant(this.Title);
}

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cabe geprek"),
        backgroundColor: const Color.fromRGBO(93, 169, 106, 1),
      ),
      body: Column(
        children: [
          const Text("Cave Geprek"),
          Container(
            child: const ListTile(
                title: Text("Restaurant 1"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place),
                        Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text("Place")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text("Ratings")
                      ],
                    ),
                  ],
                ),
                leading: Icon(Icons.person),
                // ClipRRect(
                //   borderRadius: BorderRadius.all(Radius.circular(24.0)),
                //   child: Image.asset(
                //     shop.image,
                //     width: double.infinity,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                trailing: Icon(Icons.more_vert)
            ),
          ),
          const Divider(),
          const ListTile(
              title: Text("Restaurant 1"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.place),
                      Padding(padding: EdgeInsets.only(left: 8.0)),
                      Text("Place")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Padding(padding: EdgeInsets.only(left: 8.0)),
                      Text("Ratings")
                    ],
                  ),
                ],
              ),
              leading: Icon(Icons.person),
              // ClipRRect(
              //   borderRadius: BorderRadius.all(Radius.circular(24.0)),
              //   child: Image.asset(
              //     shop.image,
              //     width: double.infinity,
              //     height: 200,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              trailing: Icon(Icons.more_vert)
          ),
          const Divider(),
          Container(
            child: const ListTile(
                title: Text("Restaurant 1"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place),
                        Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text("Place")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Padding(padding: EdgeInsets.only(left: 8.0)),
                        Text("Ratings")
                      ],
                    ),
                  ],
                ),
                leading: Icon(Icons.person),
                // ClipRRect(
                //   borderRadius: BorderRadius.all(Radius.circular(24.0)),
                //   child: Image.asset(
                //     shop.image,
                //     width: double.infinity,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                trailing: Icon(Icons.more_vert)
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kindacode.com',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJson,
              child: const Text('Load Data'),
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: ValueKey(_items[index]["id"]),
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber.shade100,
                    child: ListTile(
                      leading: Text(_items[index]["id"]),
                      title: Text(_items[index]["name"]),
                      subtitle: Text(_items[index]["dscription"]),
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
