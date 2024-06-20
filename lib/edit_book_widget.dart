import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/book.dart';

class EditBookWidget extends StatelessWidget {
  EditBookWidget({this.book, super.key});
  final Book? book;

  final bookNameController = TextEditingController();
  final bookPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (book != null) {
      bookNameController.text = book!.name;
      bookPriceController.text = book!.price.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title:
            book == null ? const Text('Add Book') : const Text('Update Book'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: bookNameController,
                decoration: const InputDecoration(
                  label: Text('Book Name'),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: bookPriceController,
                decoration: const InputDecoration(
                  label: Text('Price'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (book == null) {
                  FirebaseFirestore.instance.collection('mybook').add(Book(
                          bookNameController.text,
                          int.parse(bookPriceController.text))
                      .toMap());
                } else {
                  FirebaseFirestore.instance
                      .collection('mybook')
                      .doc(book!.id)
                      .set(Book(bookNameController.text,
                              int.parse(bookPriceController.text))
                          .toMap());
                }
                Navigator.of(context).pop();
              },
              child: book == null
                  ? const Text("add book")
                  : const Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
