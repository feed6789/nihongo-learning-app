// lib/features/vocabulary/presentation/pages/vocabulary_list_page.dart

import 'package:flutter/material.dart';
import 'package:nihongo_app/core/ultis/auth_helper.dart';
import 'package:nihongo_app/features/auth/presentation/login_page.dart';
import 'package:nihongo_app/features/vocabulary/data/datasources/category_remote_datasource.dart';
import 'package:nihongo_app/features/vocabulary/data/datasources/vocabulary_remote_datasource.dart';
import 'package:nihongo_app/features/vocabulary/data/models/category_model.dart';
import 'package:nihongo_app/features/vocabulary/data/models/vocabulary.dart';
import 'package:nihongo_app/features/vocabulary/data/repositories/vocabulary_repository.dart';
import 'package:nihongo_app/features/vocabulary/presentation/pages/vocabulary_form_page.dart';
import 'package:nihongo_app/features/vocabulary/presentation/pages/vocabulary_quiz_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VocabularyListPage extends StatefulWidget {
  const VocabularyListPage({super.key});

  @override
  State<VocabularyListPage> createState() => _VocabularyListPageState();
}

class _VocabularyListPageState extends State<VocabularyListPage> {
  late final VocabularyRepository repository;
  
  // Data States
  List<Vocabulary> allList = [];
  List<Vocabulary> filteredList = [];
  List<CategoryModel> categories = [];
  
  // UI States
  bool isLoading = true;
  int? selectedCategoryId;
  String searchText = '';
  String filterType = 'all'; // 'all', 'unlearned', 'learned', 'favorite'

  @override
  void initState() {
    super.initState();
    repository = VocabularyRepository(VocabularyRemoteDatasource());
    _loadCategories();
    _loadVocabulary();
  }

  Future<void> _loadCategories() async {
    final result = await CategoryRemoteDatasource().getVocabularyCategories();
    setState(() {
      categories = result;
    });
  }

  Future<void> _loadVocabulary() async {
    setState(() => isLoading = true);
    final data = await repository.getAll();
    if (mounted) {
      setState(() {
        allList = data;
        _applyFilter();
        isLoading = false;
      });
    }
  }

  // Tính toán tiến độ học tập
  double get _progress {
    if (allList.isEmpty) return 0.0;
    final learnedCount = allList.where((v) => v.isLearned).length;
    return learnedCount / allList.length;
  }

  void _showLoginHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Vui lòng đăng nhập để lưu tiến độ học!'),
        action: SnackBarAction(
          label: 'Đăng nhập',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthHelper.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Từ vựng JLPT'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            tooltip: 'Ôn tập',
            onPressed: () {
              // Logic Quiz: Chỉ lấy những từ chưa thuộc hoặc yêu thích để ôn
              final quizList = allList.where((v) => !v.isLearned || v.isFavorite).toList();
              
              if (quizList.length < 4) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cần ít nhất 4 từ để bắt đầu Quiz!')),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VocabularyQuizPage(vocabList: quizList)),
              );
            },
          ),
          if (user == null)
        IconButton(
          icon: const Icon(Icons.login),
          tooltip: 'Đăng nhập',
          onPressed: () async {
            // SỬA Ở ĐÂY:
            // Chờ kết quả trả về từ LoginPage
            final result = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => const LoginPage())
            );

            // Nếu result == true (đăng nhập thành công), reload lại list
            if (result == true) {
              _loadVocabulary(); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã đăng nhập và đồng bộ dữ liệu!')),
              );
            }
          },
        )
      else
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Đăng xuất',
          onPressed: () async {
            await Supabase.instance.client.auth.signOut();
            if(mounted) {
               _loadVocabulary(); // Reload lại data về trạng thái Guest
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã đăng xuất')),
              );
            }
          },
        ),
        ],
      ),
      body: Column(
        children: [
          // 1. THANH TIẾN ĐỘ & THỐNG KÊ
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tiến độ: ${( _progress * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${allList.where((v) => v.isLearned).length}/${allList.length} từ'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                  backgroundColor: Colors.white,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // 2. BỘ LỌC & TÌM KIẾM
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Tìm Kanji, Hiragana, Nghĩa...',
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          searchText = value;
                          _applyFilter();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Dropdown Category rút gọn
                    DropdownButton<int>(
                      value: selectedCategoryId,
                      hint: const Text('Chủ đề'),
                      underline: Container(), // Bỏ gạch chân mặc định
                      icon: const Icon(Icons.filter_list),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Tất cả chủ đề')),
                        ...categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.title))),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryId = value;
                          _applyFilter();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Filter Chips (Tab lọc trạng thái)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('all', 'Tất cả'),
                      _buildFilterChip('unlearned', 'Chưa học'),
                      _buildFilterChip('learned', 'Đã thuộc'),
                      _buildFilterChip('favorite', 'Đánh dấu ⭐'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. DANH SÁCH TỪ VỰNG
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredList.isEmpty
                    ? const Center(child: Text('Không tìm thấy từ vựng nào.', style: TextStyle(color: Colors.grey)))
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: filteredList.length,
                        separatorBuilder: (c, i) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final v = filteredList[index];
                          return _buildVocabularyItem(v);
                        },
                      ),
          ),
        ],
      ),
      
      // Nút thêm từ (Chỉ hiện nếu Admin hoặc User thích thêm private note - tùy logic sau này)
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (AuthHelper.isGuest) {
            _showLoginHint();
            return;
          }
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VocabularyFormPage()),
          );
          if (result == true) _loadVocabulary();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget con: Filter Chip
  Widget _buildFilterChip(String type, String label) {
    final isSelected = filterType == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              filterType = type;
              _applyFilter();
            });
          }
        },
      ),
    );
  }

  // Widget con: Dòng từ vựng
  Widget _buildVocabularyItem(Vocabulary v) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      tileColor: v.isLearned ? Colors.green.withValues(alpha: 0.1) : null, // Highlight nhẹ nếu đã thuộc
      leading: IconButton(
        icon: Icon(
          v.isLearned ? Icons.check_circle : Icons.circle_outlined,
          color: v.isLearned ? Colors.green : Colors.grey,
          size: 28,
        ),
        onPressed: () async {
          if (AuthHelper.isGuest) {
            _showLoginHint();
            return;
          }
          // Optimistic UI Update: Cập nhật UI trước khi gọi API để app mượt hơn
          setState(() {
             // Tìm và sửa trực tiếp trong allList để ko cần reload lại API
             final index = allList.indexWhere((item) => item.id == v.id);
             if (index != -1) {
               allList[index] = Vocabulary(
                 id: v.id, categoryId: v.categoryId, kanji: v.kanji, hiragana: v.hiragana, 
                 romaji: v.romaji, meaningVn: v.meaningVn, meaningEn: v.meaningEn, 
                 isFavorite: v.isFavorite, isLearned: !v.isLearned // Toggle
               );
               _applyFilter(); // Filter lại list hiển thị
             }
          });
          
          // Gọi API ngầm bên dưới
          await repository.toggleLearned(v.id, !v.isLearned);
        },
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            v.kanji.isNotEmpty ? v.kanji : v.hiragana,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (v.kanji.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text('(${v.hiragana})', style: const TextStyle(color: Colors.grey)),
          ]
        ],
      ),
      subtitle: Text(
        '${v.meaningVn} / ${v.meaningEn}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          v.isFavorite ? Icons.star : Icons.star_border,
          color: v.isFavorite ? Colors.amber : Colors.grey,
        ),
        onPressed: () async {
           if (AuthHelper.isGuest) {
            _showLoginHint();
            return;
          }
          setState(() {
             final index = allList.indexWhere((item) => item.id == v.id);
             if (index != -1) {
               allList[index] = Vocabulary(
                 id: v.id, categoryId: v.categoryId, kanji: v.kanji, hiragana: v.hiragana, 
                 romaji: v.romaji, meaningVn: v.meaningVn, meaningEn: v.meaningEn, 
                 isFavorite: !v.isFavorite, // Toggle
                 isLearned: v.isLearned 
               );
               _applyFilter();
             }
          });
          await repository.toggleFavorite(v.id, !v.isFavorite);
        },
      ),
      onTap: () {
        // Mở chi tiết (Sẽ làm sau)
      },
    );
  }

  void _applyFilter() {
    filteredList = allList.where((v) {
      // 1. Lọc theo Category
      final matchCategory = selectedCategoryId == null || v.categoryId == selectedCategoryId;

      // 2. Lọc theo Search Text
      final text = searchText.toLowerCase();
      final matchSearch = text.isEmpty ||
          v.kanji.toLowerCase().contains(text) ||
          v.hiragana.toLowerCase().contains(text) ||
          v.meaningVn.toLowerCase().contains(text) ||
          v.meaningEn.toLowerCase().contains(text);

      // 3. Lọc theo Status Tab
      bool matchStatus = true;
      if (filterType == 'learned') matchStatus = v.isLearned;
      if (filterType == 'unlearned') matchStatus = !v.isLearned;
      if (filterType == 'favorite') matchStatus = v.isFavorite;

      return matchCategory && matchSearch && matchStatus;
    }).toList();
  }
}