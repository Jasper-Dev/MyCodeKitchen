import os
import zipfile

def normalize_path(path):
    """
    Normalize the path to use forward slashes, regardless of the operating system.
    """
    return path.replace(os.sep, '/')

def check_zipped_files(parent_folder):
    """
    Checks if all files in subfolders of the given parent folder are zipped into corresponding zip files.
    Prints the names of any files that are missing in the zip files or are extra, considering path normalization.

    Parameters:
    parent_folder (str): The path to the parent folder containing the subfolders to be checked.
    """
    # Loop through all items in the parent folder
    for item in os.listdir(parent_folder):
        item_path = os.path.join(parent_folder, item)
        
        # Check if the current item is a folder
        if os.path.isdir(item_path):
            expected_zip_file = f"{item_path}.zip"
            
            # Check if the corresponding zip file exists
            if os.path.isfile(expected_zip_file):
                with zipfile.ZipFile(expected_zip_file, 'r') as zipf:
                    # Get a list of all file names in the zip file, normalized
                    zipped_files = set(normalize_path(name) for name in zipf.namelist())
                    
                    # Get a list of all file paths in the subfolder, normalized
                    subfolder_files = set()
                    for root, _, files in os.walk(item_path):
                        for file in files:
                            file_path = normalize_path(os.path.relpath(os.path.join(root, file), item_path))
                            subfolder_files.add(file_path)
                    
                    # Find differences
                    missing_in_zip = subfolder_files - zipped_files
                    extra_in_zip = zipped_files - subfolder_files

                    if missing_in_zip:
                        print(f"Missing in {expected_zip_file}:")
                        for file in missing_in_zip:
                            print(f"    {file}")
                    
                    if extra_in_zip:
                        print(f"Extra in {expected_zip_file}:")
                        for file in extra_in_zip:
                            print(f"    {file}")
            else:
                print(f"Missing zip file for folder: {item_path}")

if __name__ == "__main__":
    parent_folder_path = os.getcwd()  # Use the current working directory as the parent folder
    check_zipped_files(parent_folder_path)
