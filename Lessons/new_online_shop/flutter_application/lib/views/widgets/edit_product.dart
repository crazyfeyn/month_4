import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/product_controller.dart';
import 'package:flutter_application/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
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

  @override
  void initState() {
    titleController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    void onSubmit() async {
      String imageUrl = widget.product.imageUrl;
      if (imageFile != null) {
        imageUrl = imageFile!.path;
      }

      productController.updateProduct(
        widget.product.id,
        widget.product.category,
        imageFile!,
        false,
        double.parse(priceController.text),
        titleController.text,
      );

      titleController.clear();
      priceController.clear();
      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text("Edit Product"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Title",
            ),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Price",
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Add Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: openCamera,
                label: const Text("Camera"),
                icon: const Icon(Icons.camera),
              ),
              TextButton.icon(
                onPressed: openGallery,
                label: const Text("Gallery"),
                icon: const Icon(Icons.image),
              ),
            ],
          ),
          if (imageFile != null)
            SizedBox(
              height: 200,
              child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
            )
          else if (widget.product.imageUrl.isNotEmpty)
            SizedBox(
              height: 200,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            )
          else
            const SizedBox(
              height: 200,
              child: Center(child: Text('No image selected')),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: onSubmit,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
