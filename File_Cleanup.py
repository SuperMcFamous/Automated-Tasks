# Automated task to clean up your files
# Made by SuperMcFamous

import os
import shutil

def clear_temporary_files():
    # Directios selected to be cleaned/deleted
    temp_dirs = [
        '/tmp',            # Temporary files directory
        '/var/tmp',        # System temporary files directory
        '/var/log',        # Log files directory
        '/var/cache/apt',  # Package cache directory (for Debian-based systems)
        # More directories can be added as needed
    ]

    # Iterate over directories and remove contents
    for directory in temp_dirs:
        try:
            for root, dirs, files in os.walk(directory):
                for file in files:
                    file_path = os.path.join(root, file)
                    os.remove(file_path)
                for dir in dirs:
                    dir_path = os.path.join(root, dir)
                    shutil.rmtree(dir_path)
        except Exception as e:
            print(f"Error cleaning directory {directory}: {e}")

    print("Temporary files cleared successfully!")

if __name__ == "__main__":
    clear_temporary_files()
