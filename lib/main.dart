import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic>? _lastRemoved;
  int? _lastRemovedPos;

  @override
  void initState() {
    super.initState();

    _realData().then((data) {
      setState(() {
        if (data != null) {
          _toDoList = json.decode(data); // decodifica a string para List
        } else {
          _toDoList = [];
        }
      });
    });
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(_toDoList[index]["title"] + index.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        activeColor: Colors.blueAccent,
        // cor da caixinha marcada
        checkColor: Colors.white,
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
        secondary: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(
            _toDoList[index]["ok"] ? Icons.check : Icons.error,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        _lastRemoved = Map.from(_toDoList[index]);
        _lastRemovedPos = index;

        setState(() {
          _toDoList.removeAt(index);
          _saveData();
        });

        final snack = SnackBar(
          content: Text("Tarefa \"${_lastRemoved?["title"] ?? ""}\" removida!"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _toDoList.insert(_lastRemovedPos!, _lastRemoved!);
                _saveData();
              });
            },
          ),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  void _addToDo() {
    if (_toDoController.text.trim().isEmpty) {
      // Não faz nada se o campo estiver vazio ou só com espaços
      return;
    }

    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _toDoController.clear();
      _saveData();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data, encoding: utf8);
  }

  Future<String?> _realData() async {
    try {
      final file = await _getFile();
      return file.readAsString(encoding: utf8);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addToDo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text("ADD", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDoList.length,
                itemBuilder: buildItem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
