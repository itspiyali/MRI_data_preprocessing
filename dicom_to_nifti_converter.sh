#!/bin/bash

#mkdir -p /home/piyali/Research/Data/Imaging/NIfTI/MRI
IMAGE_DESCRIPTION=Resting_State_fMRI
DICOM_FOLDER_PATH="/home/piyali/Research/Data/Imaging/DICOM/fMRI"
NIFTI_FOLDER_PATH="/home/piyali/Research/Data/Imaging/NIfTI/fMRI"

for subj in $DICOM_FOLDER_PATH/*/; do
    subj_name=$(basename "$subj")  # Extract subject ID
    subj_nifti_path="$NIFTI_FOLDER_PATH/$subj_name"
    mkdir -p "$subj_nifti_path"  # Create subject folder in NIfTI

    for date_folder in "$subj"/${IMAGE_DESCRIPTION}/*/; do
        date_name=$(basename "$date_folder")  # Extract date folder name

        for img_folder in "$date_folder"/*/; do
            img_id=$(basename "$img_folder")  # Extract image ID
            final_nifti_path="$subj_nifti_path/${img_id}_${date_name}"  # New path format
            
            mkdir -p "$final_nifti_path"  # Create final folder for NIfTI
            dcm2niix -o "$final_nifti_path" -f "%p_%s" "$img_folder"
        done
    done
done

