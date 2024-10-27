import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/data/server/url.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  BackupScreenState createState() => BackupScreenState();
}

class BackupScreenState extends State<BackupScreen> {
  bool isLoading = false;
  String message = '';
  Future<List<String>>? backupsFuture;

  @override
  void initState() {
    super.initState();
    backupsFuture = fetchBackups(); // Fetch backups when the screen loads
  }

  Future<void> triggerBackup() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${Servername.host}backup-database'),
        headers: {
          'Accept': 'application/json',
        },
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        String data = jsonResponse['message'];
        setState(() {
          message = data;
        });
        backupsFuture =
            fetchBackups(); // Refresh backups after a successful backup
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

  Future<List<String>> fetchBackups() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${Servername.host}list-backups'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Extract the values from the response map
        final backups = jsonResponse.values.cast<String>().toList();
        return backups;
      } else {
        throw Exception(
            'Failed to fetch backups. Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch backups. Error: $e');
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
                    onPressed: () {
                      if (UserSession.type == 0) {
                        triggerBackup();
                      } else {
                        customSnackBar(context, 1, "Administrator Access Only");
                      }
                    },
                    child: const Text('Start Backup'),
                  ),
                  const SizedBox(height: 20),
                  if (message.isNotEmpty)
                    Column(
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
                          label: const Text("DONE"),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Text('Available Backups:',
                      style: Theme.of(context).textTheme.headline6),
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: backupsFuture, // Use the fetched backups
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No backups found.'));
                        } else {
                          final backups = snapshot.data!;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView.builder(
                              itemCount: backups.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Card(
                                    child: ListTile(
                                      title: Text(backups[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
