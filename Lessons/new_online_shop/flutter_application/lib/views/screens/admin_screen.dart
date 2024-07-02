import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/product_controller.dart';
import 'package:flutter_application/models/product.dart';
import 'package:flutter_application/services/product_services.dart';
import 'package:flutter_application/views/widgets/admin_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    // final productController = Provider.of<ProductController>(context);
    final productController = ProductController();
    final productServices = ProductServices();
    String title = '';
    String price = '';
    String category = '';
    File? imageFile;

    void openGallery() async {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
          source: ImageSource.gallery, requestFullMetadata: false);

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    }

    void openCamera() async {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
          source: ImageSource.camera, requestFullMetadata: false);

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    }

    final _formKey = GlobalKey<FormState>();

    void onSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        productController.addProduct(
            category, imageFile?.path, double.parse(price), title, false);
        title = '';
        price = '';
        category = '';
      } else {
        print('error occured');
      }

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // drawer: const CustomDrawer(),
      body: StreamBuilder(
        stream: productServices.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final product = Product.fromJson(snapshot.data.docs[index]);
              return AdminItem(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('add product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                openCamera();
                              },
                              icon: Icon(Icons.camera)),
                          IconButton(
                              onPressed: () {
                                openGallery();
                              },
                              icon: Icon(Icons.image)),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              initialValue: title,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Title',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Iltimos title kiriting";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  title = newValue;
                                }
                              },
                            ),
                            TextFormField(
                              initialValue: price,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Price',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Iltimos narx kiriting";
                                }
                                try {
                                  double.parse(value);
                                } catch (e) {
                                  return "Iltimos raqam kiriting";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  price = newValue;
                                }
                              },
                            ),
                            TextFormField(
                              initialValue: category,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Category',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please, enter category of product";
                                }
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  category = newValue;
                                }
                              },
                            ),
                            FilledButton(
                                onPressed: () {
                                  onSubmit();
                                },
                                child: Text('Add'))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
