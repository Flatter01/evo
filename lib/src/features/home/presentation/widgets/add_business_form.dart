import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:evo/src/features/home/data/business_service.dart';
import 'package:evo/src/features/home/data/category_service.dart';
import 'package:evo/src/features/home/data/model/category_model.dart';

class AddBusinessForm extends StatefulWidget {
  final VoidCallback onSave;

  const AddBusinessForm({super.key, required this.onSave});

  @override
  State<AddBusinessForm> createState() => _AddBusinessFormState();
}

class _AddBusinessFormState extends State<AddBusinessForm> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  String? photoPath;
  bool isPaid = false;

  final BusinessService _service = BusinessService();
  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> categories = [];
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final result = await _categoryService.fetchCategory();
    setState(() {
      categories = result;
      if (categories.isNotEmpty) {
        selectedCategoryId = categories.first.id;
      }
    });
  }

  Future pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        photoPath = picked.path;
      });
    }
  }

  void addData() async {
    if (photoPath == null || selectedCategoryId == null) return;

    await _service.addBusiness(
      userFullName: nameController.text,
      userPhone: phoneController.text,
      description: descriptionController.text,
      photoPath: photoPath!,
      categoryId: selectedCategoryId!, // 👈 передаём выбранную категорию
    );

    // Очистка
    nameController.clear();
    phoneController.clear();
    locationController.clear();
    descriptionController.clear();
    photoPath = null;
    isPaid = false;

    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: "ФИО")),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Телефон")),
          TextField(controller: locationController, decoration: const InputDecoration(labelText: "Геолокация")),
          TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Описание")),
          const SizedBox(height: 10),

          // 👇 Категория Dropdown
          DropdownButtonFormField<int>(
            value: selectedCategoryId,
            decoration: const InputDecoration(labelText: "Категория"),
            items: categories.map((category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
            },
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(onPressed: pickPhoto, child: const Text("Выбрать фото")),
              const SizedBox(width: 10),
              if (photoPath != null) const Icon(Icons.check, color: Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: addData, child: const Text("Сохранить")),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
