import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  BackupScreenState createState() => BackupScreenState();
}

class BackupScreenState extends State<BackupScreen> {
  bool isLoading = false;
  String message = '';

  Future<void> triggerBackup() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${Servername.host}backup-database'),
        headers: {
          // 'Authorization': 'Bearer YOUR_API_TOKEN',
          'Accept': 'application/json',
        },
      );
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        String data = jsonResponse['message'];
        setState(() {
          message = data;
        });
      } else {
        setState(() {
          message = 'Failed to upload backup. Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Failed to upload backup. Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Backup'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: triggerBackup,
                    child: const Text('Start Backup'),
                  ),
                  const SizedBox(height: 20),
                  if (message.isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            color: message.contains('successfully')
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {
                              setState(() {
                                isLoading = false;
                                message = '';
                              });
                            },
                            icon: const Icon(Icons.done),
                            label: const Text("DONE")),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
