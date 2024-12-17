import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/database/components/confirm_dialog.dart';
import 'package:repository_ustp/src/data/server/url.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  late StreamController<List<String>> _backupStreamController;
  bool isLoading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    _backupStreamController = StreamController<List<String>>();
    fetchBackups();
  }

  @override
  void dispose() {
    _backupStreamController.close();
    super.dispose();
  }

  /// Reload function to fetch backups again
  void reload() {
    setState(() {
      fetchBackups();
      message = "";
    });
  }

  /// Fetch backups and push to stream
  Future<void> fetchBackups() async {
    try {
      final response = await http.get(
        Uri.parse('${Servername.host}list-backups'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        List<String> backups = [];

        if (jsonResponse is List) {
          backups = jsonResponse.cast<String>();
        } else if (jsonResponse is Map) {
          backups = jsonResponse.values.cast<String>().toList();
        } else {
          throw Exception('Unexpected JSON format');
        }

        _backupStreamController.add(backups);
      } else {
        _backupStreamController
            .addError('Failed to fetch backups. Error: ${response.statusCode}');
      }
    } catch (e) {
      _backupStreamController.addError('Failed to fetch backups. Error: $e');
    }
  }

  /// Trigger backup creation
  Future<void> triggerBackup() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${Servername.host}backup-database'),
        headers: {'Accept': 'application/json'},
      );

      final dynamic jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          message = jsonResponse['message'] ?? 'Backup created successfully!';
        });
        fetchBackups(); // Reload backups
      } else {
        setState(() {
          message = jsonResponse['error'] ?? 'Failed to create backup.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Failed to create backup. Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteBackup(String fileName) async {
    try {
      final response = await http.delete(
        Uri.parse('${Servername.host}delete-backup/$fileName'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        setState(() {
          message = jsonResponse['message'] ?? 'Backup deleted successfully!';
        });
        fetchBackups(); // Reload backups after deletion
      } else {
        setState(() {
          message = 'Failed to delete backup. Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Failed to delete backup. Error: $e';
      });
    }
  }

  /// Restore database from a backup file
  Future<void> restoreBackup(String fileName) async {
    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${Servername.host}restore-backup/$fileName'),
        headers: {'Accept': 'application/json'},
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          message =
              jsonResponse['message'] ?? 'Database restored successfully!';
        });
      } else {
        setState(() {
          message = jsonResponse['error'] ?? 'Failed to restore database.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Failed to restore database. Error: $e';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Database Backup'),
            IconButton(
              onPressed: reload,
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: ElevatedButton(
              onPressed: triggerBackup,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text(
                'Create Backup',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (isLoading) const LinearProgressIndicator(),
          if (message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _backupStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No backups available.'));
                } else {
                  final backups = snapshot.data!;
                  return ListView.builder(
                    itemCount: backups.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.file_copy),
                          title: Text(backups[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.restore,
                                    color: Colors.green),
                                onPressed: () {
                                  showRestoreConfirmationDialog(context,
                                      restoreBackup, backups[index], "Restore");
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showRestoreConfirmationDialog(context,
                                      deleteBackup, backups[index], "Delete");
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
