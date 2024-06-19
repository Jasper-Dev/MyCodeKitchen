import os
import zipfile

def normalize_path(path):
    """
    Normalize the path to use forward slashes, regardless of the operating system.
    """
    return path.replace(os.sep, '/')

def delete_files_and_folders_in_zip(parent_folder):
    """
    Deletes files and subfolders in the given parent folder that are already zipped into corresponding zip files,
    after receiving user confirmation. Excludes the root folder from deletion.

    Parameters:
    parent_folder (str): The path to the parent folder containing the subfolders and zip files.
    """
    confirmation = input("This will delete files and subfolders that are already zipped. Are you sure? (y/n): ")
    if confirmation.lower() != 'y':
        print("Operation cancelled.")
        return

    for item in os.listdir(parent_folder):
        item_path = os.path.join(parent_folder, item)
        
        if os.path.isdir(item_path):
            expected_zip_file = f"{item_path}.zip"
            
            if os.path.isfile(expected_zip_file):
                with zipfile.ZipFile(expected_zip_file, 'r') as zipf:
                    zipped_files = set(normalize_path(name) for name in zipf.namelist())
                    
                    for root, _, files in os.walk(item_path, topdown=False):
                        for file in files:
                            file_path = os.path.join(root, file)
                            normalized_file_path = normalize_path(os.path.relpath(file_path, item_path))
                            
                            if normalized_file_path in zipped_files:
                                try:
                                    os.remove(file_path)
                                    print(f"Deleted: {file_path}")
                                except Exception as e:
                                    print(f"Error deleting {file_path}: {e}")
                        
                        # Attempt to remove the folder if it's empty
                        if not os.listdir(root):
                            try:
                                os.rmdir(root)
                                print(f"Removed folder: {root}")
                            except OSError as e:
                                print(f"Error removing {root}: {e}")

if __name__ == "__main__":
    parent_folder_path = os.getcwd()  # Use the current working directory as the parent folder
    delete_files_and_folders_in_zip(parent_folder_path)
