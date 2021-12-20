import 'package:flutter/material.dart';

class UserInfoItem extends StatelessWidget {
  const UserInfoItem(
      {Key? key,
      required this.edit,
      required this.controller,
      required this.onPressed})
      : super(key: key);

  final bool edit;
  final TextEditingController controller;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          Flexible(
            child: edit
                ? TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  )
                : Text(
                    controller.text,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
          ),
          TextButton(
              onPressed: () => onPressed(),
              child: Text(
                edit ? 'Save' : 'Edit',
              ))
        ],
      ),
    );
  }
}
