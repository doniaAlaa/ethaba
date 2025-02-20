import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDocumentWidget extends StatelessWidget {
  final String title;
  final List<String> files;
  final String baseUrl;

  const ProjectDocumentWidget({
    Key? key,
    required this.title,
    required this.files,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: files.map((file) => buildFileItem(file)).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => downloadAll(files),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download),
              SizedBox(width: 5),
              Text('Download All'),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildFileItem(String file) {
    String fileExtension = file.split('.').last.toLowerCase();
    IconData icon;
    Color color;

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(fileExtension)) {
      return GestureDetector(
        onTap: () => _launchURL('$baseUrl/$file'),
        child: Image.network(
          '$baseUrl/$file',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    } else if (fileExtension == 'pdf') {
      icon = Icons.picture_as_pdf;
      color = Colors.red;
    } else if (fileExtension == 'doc' || fileExtension == 'docx') {
      icon = Icons.description;
      color = Colors.blue;
    } else {
      icon = Icons.insert_drive_file;
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: () => _launchURL('$baseUrl/$file'),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  void downloadAll(List<String> files) {
    for (String file in files) {
      _launchURL('$baseUrl/$file');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
