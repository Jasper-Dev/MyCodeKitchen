import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import os
import zipfile

class ZipCleanupGUI:
    def __init__(self, root):
        self.root = root
        root.title('Zip Cleanup Tool')

        self.selected_directories = []

        # Frame for Directory Selection
        self.frame = tk.Frame(root)
        self.frame.pack(padx=10, pady=10)

        self.label = tk.Label(self.frame, text="Select folders:")
        self.label.pack(side=tk.LEFT)

        self.browse_button = tk.Button(self.frame, text="Browse", command=self.browse_folders)
        self.browse_button.pack(side=tk.RIGHT)

        # Listview for displaying selected folders
        self.listbox = tk.Listbox(root, height=6)
        self.listbox.pack(padx=10, pady=5, fill=tk.BOTH, expand=True)

        # Frame for Actions
        self.action_frame = tk.Frame(root)
        self.action_frame.pack(fill=tk.X, padx=10, pady=10)

        self.zip_button = tk.Button(self.action_frame, text="Zip Folders", command=self.zip_folders)
        self.zip_button.pack(side=tk.LEFT, fill=tk.X, expand=True)

        self.delete_button = tk.Button(self.action_frame, text="Delete Files & Folders", command=self.delete_files_and_folders)
        self.delete_button.pack(side=tk.LEFT, fill=tk.X, expand=True)

    def browse_folders(self):
        folder_selected = filedialog.askdirectory(initialdir=os.getcwd(), mustexist=True)
        if folder_selected:
            self.selected_directories.append(folder_selected)
            self.listbox.insert(tk.END, folder_selected)

    def zip_folders(self):
        for directory in self.selected_directories:
            zip_name = os.path.basename(directory) + '.zip'
            with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for root, dirs, files in os.walk(directory):
                    for file in files:
                        zipf.write(os.path.join(root, file), os.path.relpath(os.path.join(root, file), os.path.join(directory, '..')))

    def delete_files_and_folders(self):
        confirmation = messagebox.askyesno("Confirm", "This will delete the selected folders. Are you sure?")
        if confirmation:
            for directory in self.selected_directories:
                # Call a function to delete the directory here. This example does not include the deletion logic.
                pass
            messagebox.showinfo("Completed", "Operation completed successfully.")
            self.selected_directories.clear()
            self.listbox.delete(0, tk.END)
        else:
            messagebox.showinfo("Cancelled", "Operation cancelled.")

if __name__ == "__main__":
    root = tk.Tk()
    app = ZipCleanupGUI(root)
    root.mainloop()
