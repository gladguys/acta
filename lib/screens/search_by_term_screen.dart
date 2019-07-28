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
      subtitle: 'Terms',
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
    return Container(
      width: 300.0,
      margin: EdgeInsets.only(right: 8.0),
      child: TextFormField(
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          hintText: 'Search here...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 3.0,
            ),
          ),
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Enter some term to search';
        },
        controller: _termController,
      ),
    );
  }

  Widget _buildSearchButton() {
    return Container(
      width: 60.0,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
          size: 32.0,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              term = _termController.text;
            });
          }
        },
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
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTermTextField(),
                _buildSearchButton(),
              ],
            ),
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
