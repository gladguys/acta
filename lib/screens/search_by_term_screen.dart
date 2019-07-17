import 'package:flutter/material.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/widgets/news_cards_list.dart';

class SearchByTermScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchByTermState();
  }
}

class _SearchByTermState extends State<SearchByTermScreen> {
  String term;
  final _provider = NewsProvider();
  final _formKey = GlobalKey<FormState>();
  final _termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    term = '';
  }

  @override
  void dispose() {
    _termController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Terms',
      body: _buildSearchByTermScreen(),
      initialTab: 2,
    );
  }

  Widget _buildNewsByTerm() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getNewsByTerm(term),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(news: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildTermTextField() {
    return TextFormField(
      validator: (value) {
        return value.isEmpty ? 'Enter some term to search' : '';
      },
      controller: _termController,
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              term = _termController.text;
            });
          }
        },
        child: Text('Search'),
      ),
    );
  }

  Widget _buildSearchByTermResult() {
    return term == '' ? Container() : _buildNewsByTerm();
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTermTextField(),
            _buildSearchButton(),
            _buildSearchByTermResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchByTermScreen() {
    return SingleChildScrollView(reverse: true, child: _buildForm());
  }
}
