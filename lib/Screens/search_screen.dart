import 'package:flutter/material.dart';
import 'package:weather_app/utils/utils.dart';

class SearchScreen extends StatefulWidget {
  final Function(String) onSearch;

  SearchScreen({required this.onSearch});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    String cityName = '';

    return Scaffold(
      backgroundColor: Color(0xff212F3C),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), // Adjust the value as needed
                color: Colors.white,
              ),
              child: TextField(
                onChanged: (value) {
                  cityName = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (cityName.trim().isEmpty) {
                        Utils().toastMessage("Please Enter City Name.");
                      } else {
                        widget.onSearch(cityName);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                  hintText: 'Enter City Name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0), // Adjust padding as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
