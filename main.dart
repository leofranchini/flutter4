import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD em Memória',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioScreen(),
    );
  }
}


class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final TextEditingController _controller = TextEditingController();

  void _navegarParaLista(BuildContext context, String item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite um item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String item = _controller.text;
                if (item.isNotEmpty) {
                  _navegarParaLista(context, item);
                  _controller.clear();
                }
              },
              child: Text('Adicionar e Listar'),
            ),
          ],
        ),
      ),
    );
  }
}


class ListaScreen extends StatefulWidget {
  final String item;

  ListaScreen({required this.item});

  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final List<String> _itens = [];

  @override
  void initState() {
    super.initState();
    
    _itens.add(widget.item);
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
      ),
      body: _itens.isEmpty
          ? Center(child: Text('Nenhum item adicionado.'))
          : ListView.builder(
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_itens[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removerItem(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar Item',
      ),
    );
  }
}
