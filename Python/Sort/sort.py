import os
from PIL import Image
from datetime import datetime
from pathlib import Path

# Source directory
src_dir = Path("D:/Users/Jasper/Desktop/GreenShot")
# Destination directory
dst_dir = Path("D:/Users/Jasper/Desktop/screenshots")

# Create the destination directory if it doesn't exist
dst_dir.mkdir(parents=True, exist_ok=True)

for file_path in src_dir.iterdir():
    if file_path.is_file() and file_path.suffix in [".png", ".jpg"]:
        try:
            # Open image file
            img = Image.open(file_path)
            # Extract DateTimeOriginal metadata
            exif_data = img._getexif()
            if exif_data is not None and 36867 in exif_data:
                datetime_original = exif_data[36867]  # 36867 is the tag id for DateTimeOriginal
                # Parse the date and time
                date, time = datetime_original.split()
                year, month, day = date.split(':')
            else:
                # Use the file's last modified time if the EXIF data isn't available
                timestamp = os.path.getmtime(file_path)
                dt = datetime.fromtimestamp(timestamp)
                year, month, day = str(dt.year), str(dt.month).zfill(2), str(dt.day)
            
            # Create a directory for each year
            year_dir = dst_dir / year
            year_dir.mkdir(exist_ok=True)

            # Create a directory for each month within the year directory
            month_dir = year_dir / month
            month_dir.mkdir(exist_ok=True)

            # Move the file to the destination directory
            dst_file_path = month_dir / file_path.name
            os.rename(file_path, dst_file_path)

        except (PermissionError, OSError, IOError, ValueError, TypeError) as e:
            print(f"Skipping file {file_path} due to error: {e}")
            continue
