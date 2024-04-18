import 'package:flutter/material.dart';
import 'package:starter/networking/api_service.dart';

class ListBooksScreen extends StatefulWidget {
  const ListBooksScreen({super.key});

  @override
  State<ListBooksScreen> createState() => _ListBooksScreenState();
}

class _ListBooksScreenState extends State<ListBooksScreen> {
   TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> books = ['Book 1', 'Book 2', 'Book 3', 'Book 4'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Books',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMyDialog();
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: FutureBuilder(
            future: ApiService().getBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong!'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index]['name']), // Supondo que os dados são uma lista de livros.
                    );
                  },
                  itemCount: snapshot.data?.length,
                );
              }
            },
          ),
        )
    );
  }
   Future<void> _showMyDialog() async {

     return showDialog<void>(
       context: context,
       barrierDismissible: false, // user must tap button!
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text('Add Book'),
           content:  SingleChildScrollView(
             child: ListBody(
               children: <Widget>[
                 Text('Book Name'),
                 TextField(controller:textEditingController),
               ],
             ),
           ),
           actions: <Widget>[
             TextButton(
               child:  const Text('Save'),
               onPressed: () async{
                await ApiService().createBook({"book_name":textEditingController.text});
                 print(textEditingController.text);
                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }


}
