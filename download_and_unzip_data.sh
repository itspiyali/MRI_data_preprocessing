#!/bin/bash

# Paths
LINKS_FILE="/home/piyali/Piyali/Data/Imaging/Info/RS_fMRI_URL.txt"
ZIP_FOLDER="/home/piyali/Piyali/Data/Imaging/Zip_files"
DICOM_FOLDER="/home/piyali/Piyali/Data/Imaging/DICOM/fMRI"

# Create necessary folders
mkdir -p "$ZIP_FOLDER" "$DICOM_FOLDER"

# Process each link
i=1
while read -r LINK; do
  ZIP_FILE="$ZIP_FOLDER/fMRI_file_$i.zip"
  DICOM_SUBFOLDER="$DICOM_FOLDER/fMRI_$i"
  LOG_FILE="$ZIP_FOLDER/fMRI_${i}_download_failed.log"

  # Download the zip file
  wget -c -O "$ZIP_FILE" "$LINK"

  # Check if the file is fully downloaded
  if [ $? -eq 0 ] && [ -s "$ZIP_FILE" ]; then
    echo "${i}-th zip file is downloaded successfully"
    
    # Extract only if the file is valid
    mkdir -p "$DICOM_SUBFOLDER"
    unzip -o "$ZIP_FILE" -d "$DICOM_SUBFOLDER"
    echo "${i}-th zip file is extracted"
  else
    echo "Failed to download file $i: $LINK" | tee "$LOG_FILE"
    rm -f "$ZIP_FILE"  # Remove the incomplete file
  fi

  ((i++))
done < "$LINKS_FILE"

echo "All downloads attempted. Check $ZIP_FOLDER for any failed download logs."

