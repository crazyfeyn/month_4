import 'package:flutter/material.dart';
import 'package:flutter_application/cubits/shop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDialog extends StatefulWidget {
  String id;
  String title;
  String price;
  String imageUrl;
  EditDialog(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final titlecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final photocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titlecontroller.text = widget.title;
    pricecontroller.text = widget.price;
    photocontroller.text = widget.imageUrl;

    final controller = context.read<ShopCubit>();
    final formkey = GlobalKey<FormState>();
    save() {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        controller.editProduct(titlecontroller.text, widget.id,
            photocontroller.text, double.parse(pricecontroller.text));
        Navigator.pop(context);
      }
    }

    return SingleChildScrollView(
      child: AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
          ElevatedButton(
            onPressed: save,
            child: const Text("Done"),
          ),
        ],
        content: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ma`lumot kirg`izng!';
                  }
                  return null;
                },
                controller: titlecontroller,
                decoration: InputDecoration(
                  labelText: 'Input title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ma`lumot kirg`izng!';
                  }

                  return null;
                },
                controller: pricecontroller,
                decoration: InputDecoration(
                  labelText: 'Input price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ma`lumot kirg`izng!';
                  }
                  return null;
                },
                controller: photocontroller,
                decoration: InputDecoration(
                  labelText: 'Input url of photo!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              if (photocontroller.text.isNotEmpty)
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.network(photocontroller.text),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
