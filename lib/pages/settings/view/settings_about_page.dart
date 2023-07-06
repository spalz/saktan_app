import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/editorjs/editorjs.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/settings/settings.dart';
import 'package:saktan_app/utils/utils.dart';

class SettingsAboutPage extends StatefulWidget {
  const SettingsAboutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsAboutPage> createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  final String _currentLanguage = Intl.getCurrentLocale();
  bool _isLoadRunning = true;
  SettingsAbout? _post;

  void _firstLoad() async {
    try {
      setState(() {
        _isLoadRunning = true;
      });

      final fetchedPost = await fetchSettingsAbout();
      setState(() {
        _post = fetchedPost;
        _isLoadRunning = false;
      });
    } catch (err) {
      // Handle the error, show an error message, etc.
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getT(
            _currentLanguage,
            _post?.titleRu ?? S.of(context).titleLoading,
            _post?.titleKy ?? S.of(context).titleLoading),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: Colors.white,
        settings: false,
      ),
      body: SingleChildScrollView(
        child: SelectionArea(
          child: _isLoadRunning
              ? const LinearProgressIndicator(
                  backgroundColor: Color.fromRGBO(90, 220, 190, 1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(240, 244, 255, 1),
                  ),
                )
              : _post != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditorJSView(
                              editorJSData: getT(_currentLanguage,
                                  _post!.bodyRu, _post!.bodyKy)),
                          const SizedBox(height: 80),
                        ],
                      ),
                    )
                  : const SizedBox(),
        ),
      ),
    );
  }
}
