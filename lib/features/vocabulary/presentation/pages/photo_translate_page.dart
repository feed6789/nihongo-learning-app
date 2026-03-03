import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';

class PhotoTranslatePage extends StatefulWidget {
  const PhotoTranslatePage({super.key});

  @override
  State<PhotoTranslatePage> createState() => _PhotoTranslatePageState();
}

class _PhotoTranslatePageState extends State<PhotoTranslatePage> {
  File? _image;
  String _extractedText = '';
  String _translatedText = '';
  bool _isProcessing = false;

  // 1. Khởi tạo bộ nhận diện chữ (Script Japanese để đọc Kanji/Kana)
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.japanese);
  
  // 2. Khởi tạo bộ dịch (Nhật -> Việt)
  final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: TranslateLanguage.japanese,
    targetLanguage: TranslateLanguage.vietnamese,
  );

  @override
  void dispose() {
    _textRecognizer.close();
    _onDeviceTranslator.close();
    super.dispose();
  }

  // Hàm chọn ảnh và xử lý
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _isProcessing = true;
      _extractedText = '';
      _translatedText = '';
    });

    try {
      final inputImage = InputImage.fromFilePath(pickedFile.path);

      // BƯỚC 1: OCR - Đọc chữ từ ảnh
      final recognizedText = await _textRecognizer.processImage(inputImage);
      final rawText = recognizedText.text;

      if (rawText.isEmpty) {
        setState(() => _extractedText = 'Không tìm thấy văn bản nào.');
        return;
      }

      setState(() => _extractedText = rawText);

      // BƯỚC 2: Dịch thuật
      // Lưu ý: Lần đầu chạy nó sẽ cần tải model ngôn ngữ về máy (khoảng 30MB)
      final translated = await _onDeviceTranslator.translateText(rawText);
      
      setState(() => _translatedText = translated);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dịch qua hình ảnh')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Khu vực hiển thị ảnh
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 16),

            // Các nút chọn ảnh
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Chụp ảnh'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Thư viện'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            if (_isProcessing)
              const Center(child: CircularProgressIndicator())
            else ...[
              // Hiển thị kết quả Tiếng Nhật gốc
              const Text('🇯🇵 Văn bản gốc:', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  _extractedText.isEmpty ? 'Chưa có dữ liệu' : _extractedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              // Hiển thị kết quả Tiếng Việt
              const Text('🇻🇳 Bản dịch:', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  _translatedText.isEmpty ? '...' : _translatedText,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}