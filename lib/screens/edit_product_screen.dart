import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String id, description, title, imageUrl = '';
  double price = 0;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      print('changed');
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    var product = Product(
      description: description,
      imageUrl: imageUrl,
      title: title,
      price: price,
      id: id,
    );
    Provider.of<Products>(context, listen: false).addProduct(product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title *'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is mandatory';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) => title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must provide price';
                  } else if (double.tryParse(value) == null) {
                    return 'Price must be a number';
                  }
                  return null;
                },
                onSaved: (value) => price = double.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                onSaved: (value) => description = value,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 8),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isNotEmpty
                        ? Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          )
                        : Text('Enter Image URL'),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value.isEmpty ? 'Image URL is must' : null,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (value) {
                        _saveForm();
                      },
                      onSaved: (value) => imageUrl = value,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
