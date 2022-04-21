import 'package:flutter/material.dart';
import 'package:new_project/provider/todoprovider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Todohome extends StatefulWidget {
  Todohome({Key? key}) : super(key: key);

  @override
  State<Todohome> createState() => _TodohomeState();
}

class _TodohomeState extends State<Todohome> {
  final _contrroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool switchValue = false;

  void addtodo() {
    final valid = formKey.currentState!.validate();
    if (valid) {
      formKey.currentState!.save();
      Provider.of<Todoitem>(context, listen: false).addTodo(_contrroller.text);
      _contrroller.clear();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ADD NEW TODO'),
        content: Form(
          key: formKey,
          child: TextFormField(
            validator: ((value) {
              return value!.isNotEmpty ? null : "Please Enter something";
            }),
            controller: _contrroller,
            decoration: const InputDecoration(
              labelText: 'Enter a Todo',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addtodo();
              Navigator.of(ctx).pop();
            },
            child: const Text('ADD'),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('CANCEL'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getTodos = Provider.of<Todoitem>(context).listtodo;
    var pendingpersent = getTodos.length / 50;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODOS",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 5000,
              lineHeight: 20.0,
              percent: pendingpersent,
              center: const Text(
                'Pending Todos',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              // ignore: deprecated_member_use
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.blue[400],
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: getTodos.length,
              itemBuilder: ((context, index) {
                var recentTodos = getTodos[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<Todoitem>(context, listen: false)
                                .removeTodo(recentTodos);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Successfully Deleted'),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    Provider.of<Todoitem>(context,
                                            listen: false)
                                        .addTodo(recentTodos);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          getTodos[index],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showErrorDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
