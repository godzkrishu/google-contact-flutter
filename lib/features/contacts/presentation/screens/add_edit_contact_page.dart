import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/app_toast.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';

class AddEditContactPage extends StatefulWidget {
  static const String routeName = "add-edit-contact-page";
  static const String routePath = "/add-edit-contact-page";

  final ContactEntity? contact;

  const AddEditContactPage({super.key, this.contact});

  @override
  State<AddEditContactPage> createState() => _AddEditContactPageState();
}

class _AddEditContactPageState extends State<AddEditContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isFavorite = false;

  bool get _isEdit => widget.contact != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final c = widget.contact!;
      _nameController.text = c.name;
      _phoneController.text = c.phone;
      _emailController.text = c.email;
      _companyController.text = c.company ?? '';
      _notesController.text = c.notes ?? '';
      _isFavorite = c.isFavorite;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final contact = ContactEntity(
      id: _isEdit ? widget.contact!.id : const Uuid().v4(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      company: _companyController.text.trim(),
      notes: _notesController.text.trim(),
      profileImage: null,
      isFavorite: _isFavorite,
      createdAt: _isEdit ? widget.contact!.createdAt : DateTime.now(),
    );

    if (_isEdit) {
      context.read<ContactsBloc>().add(ContactsEvent.updateContact(contact));
    } else {
      context.read<ContactsBloc>().add(ContactsEvent.addContact(contact));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      listener: (BuildContext context, ContactsState state) {
        // SUCCESS
        if (state.addContactStatus == ContactStatus.completed) {
          AppToast.showSuccess('Contact saved successfully');

          Navigator.pop(context);
        }

        // ERROR
        if (state.addContactStatus == ContactStatus.error) {
          AppToast.showError(state.message);
        }

        // UPDATE SUCCESS
        if (state.updateContactStatus == ContactStatus.completed) {
          AppToast.showSuccess('Contact updated successfully');

          Navigator.pop(context);
        }

        // UPDATE ERROR
        if (state.updateContactStatus == ContactStatus.error) {
          AppToast.showError(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(_isEdit ? 'Edit Contact' : 'Add Contact')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      child: ValueListenableBuilder(
                        valueListenable: _nameController,
                        builder: (_, value, __) {
                          final text = value.text;
                          return Text(
                            text.isNotEmpty ? text[0].toUpperCase() : '?',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Required section
                  _sectionLabel('Required'),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Phone is required'
                        : null,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address *',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Optional section
                  _sectionLabel('Optional'),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _companyController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Company',
                      prefixIcon: Icon(Icons.business_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      prefixIcon: Icon(Icons.notes_outlined),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Favorite toggle
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SwitchListTile(
                      value: _isFavorite,
                      onChanged: (v) => setState(() => _isFavorite = v),
                      title: const Text('Mark as Favorite'),
                      secondary: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _submit,
                      icon: Icon(_isEdit ? Icons.save_outlined : Icons.add),
                      label: Text(
                        _isEdit ? 'Update Contact' : 'Save Contact',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
        letterSpacing: 0.5,
      ),
    );
  }
}
