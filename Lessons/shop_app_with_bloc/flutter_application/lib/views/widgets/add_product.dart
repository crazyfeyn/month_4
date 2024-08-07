import 'package:flutter/material.dart';
import 'package:flutter_application/cubits/shop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final titlecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final photocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ShopCubit>();
    final formkey = GlobalKey<FormState>();
    save() {
      if (formkey.currentState!.validate()) {
        setState(() {});
        formkey.currentState!.save();
        controller.addProduct(titlecontroller.text, UniqueKey().toString(),
            photocontroller.text, double.parse(pricecontroller.text));
        Navigator.pop(context);
      }
    }

    return AlertDialog(
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
          ],
        ),
      ),
    );
  }
}
