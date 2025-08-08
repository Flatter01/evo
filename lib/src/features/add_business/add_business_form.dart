import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:evo/src/core/colors/app_colors.dart';
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
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final businessNameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  String? image;
  bool isPaid = false;
  int? selectedCategoryId;

  final _service = BusinessService();
  final _categoryService = CategoryService();

  List<CategoryModel> categories = [];

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

  Future<void> pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        image = picked.path;
      });
    }
  }

  void clearForm() {
    nameController.clear();
    businessNameController.clear();
    phoneController.clear();
    locationController.clear();
    descriptionController.clear();
    image = null;
    isPaid = false;
    selectedCategoryId = categories.isNotEmpty ? categories.first.id : null;
  }

  Future<void> addData() async {
    if (!_formKey.currentState!.validate()) return;
    if (image == null || selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Заполните все поля и выберите фото")),
      );
      return;
    }

    await _service.addBusiness(
      userFullName: nameController.text.trim(),
      userPhone: phoneController.text.trim(),
      description: descriptionController.text.trim(),
      image: image!,
      categoryId: selectedCategoryId!,
      name: businessNameController.text.trim(),
      location: locationController.text.trim(),
    );

    clearForm();
    widget.onSave();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration("ФИО"),
                validator: (value) =>
                    value!.isEmpty ? "Введите ФИО" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: businessNameController,
                decoration: _inputDecoration("Название бизнеса"),
                validator: (value) =>
                    value!.isEmpty ? "Введите название" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                decoration: _inputDecoration("Телефон"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Введите телефон" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: locationController,
                decoration: _inputDecoration("Геолокация"),
                validator: (value) =>
                    value!.isEmpty ? "Введите геолокацию" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: _inputDecoration("Описание"),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Введите описание" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedCategoryId,
                decoration: _inputDecoration("Категория"),
                items: categories.map((category) {
                  return DropdownMenuItem<int>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  selectedCategoryId = value;
                }),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: pickPhoto,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.stoneGrey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.photo, color: AppColors.stoneGrey),
                      const SizedBox(width: 10),
                      Text(
                        image == null ? "Выбрать фото" : "Фото выбрано ✅",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              if (image != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(image!),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.stoneGrey,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: addData,
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
