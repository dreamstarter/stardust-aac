import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/edit_mode_provider.dart';
import '../providers/photos_provider.dart';
import '../models/database.dart';

/// Main communication board screen with photo grid
class CommunicationBoardScreen extends StatelessWidget {
  const CommunicationBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Stardust'),
        trailing: Consumer<EditModeProvider>(
          builder: (context, editMode, _) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => editMode.toggleEditMode(),
              child: Text(editMode.isEditMode ? 'Done' : 'Edit'),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Consumer<PhotosProvider>(
          builder: (context, photosProvider, _) {
            if (photosProvider.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (photosProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_triangle,
                      size: 48,
                      color: CupertinoColors.systemRed,
                    ),
                    const SizedBox(height: 16),
                    Text('Error: ${photosProvider.error}'),
                    CupertinoButton(
                      onPressed: photosProvider.refresh,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (photosProvider.photos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.photo_on_rectangle,
                      size: 64,
                      color: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No photos yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap Edit to add your first photo',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey2,
                      ),
                    ),
                  ],
                ),
              );
            }

            return _buildPhotoGrid(context, photosProvider.photos);
          },
        ),
      ),
    );
  }

  Widget _buildPhotoGrid(BuildContext context, List<Photo> photos) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Will be dynamic based on settings later
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return _buildPhotoTile(context, photo);
        },
      ),
    );
  }

  Widget _buildPhotoTile(BuildContext context, Photo photo) {
    return GestureDetector(
      onTap: () {
        // TODO: Play audio or show preview
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.photo,
              size: 48,
              color: CupertinoColors.systemGrey,
            ),
            const SizedBox(height: 8),
            Text(
              photo.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
