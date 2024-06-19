import os
import zipfile

def zip_subfolders(parent_folder):
    """
    Zips the content of every subfolder in the given parent_folder into individual
    zip files named after each subfolder. It asks for user confirmation before proceeding.

    Parameters:
    parent_folder (str): The path to the parent folder containing the subfolders to be zipped.
    """
    
    # Ask for user confirmation
    confirmation = input(f"Are you sure you want to zip all subfolders in '{parent_folder}'? (y/n): ")
    
    if confirmation.lower() != 'y':
        print("Operation cancelled.")
        return

    # Loop through all items in the parent folder
    for item in os.listdir(parent_folder):
        item_path = os.path.join(parent_folder, item)

        # Check if the current item is a folder
        if os.path.isdir(item_path):
            zip_file_path = f"{item_path}.zip"

            # Create a ZipFile object in WRITE mode
            with zipfile.ZipFile(zip_file_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for root, _, files in os.walk(item_path):
                    for file in files:
                        # Create the full path to the file
                        file_path = os.path.join(root, file)
                        # Create the arcname for the file relatively to the folder being zipped
                        arcname = os.path.relpath(file_path, item_path)
                        # Write the file to the zip file
                        zipf.write(file_path, arcname)

            print(f"Created zip file: {zip_file_path}")

if __name__ == "__main__":
    # Use the current working directory as the parent folder
    parent_folder_path = os.getcwd()
    print(f"Current directory: {parent_folder_path}")
    zip_subfolders(parent_folder_path)
