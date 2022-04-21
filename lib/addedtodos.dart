import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  final Function(
    String listtodo,
  ) function;
  Addtodo(this.function);

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  final _contrroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var entertodo = '';

  void addtodo() {
    final valid = formKey.currentState!.validate();
    if (valid) {
      formKey.currentState!.save();
      widget.function(_contrroller.text);
      _contrroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: ((value) {
                      return value!.isNotEmpty
                          ? null
                          : "Please Enter something";
                    }),
                    controller: _contrroller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a Todo',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () => addtodo(),
              hoverColor: Colors.amber,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
