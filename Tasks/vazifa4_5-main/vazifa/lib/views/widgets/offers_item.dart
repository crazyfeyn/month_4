import 'package:flutter/material.dart';

class OffersItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final List<Widget> trailing;

  const OffersItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(leadingIcon),
          title:  Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle:  Text(subtitle),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: trailing,
          ),
        ),
      ),
    );
  }
}
