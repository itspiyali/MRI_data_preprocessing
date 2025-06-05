#!/bin/bash
"
run it like this:
`bash sesegment_MRIs_using_FSL.sh </path/to/subject/directory> \
                                 </path/to/delimited/text/file/containing/all/subject_IDs.txt>`
"
# Check if both arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <SUBJECT_DIR> <path_to_mris.txt>"
    exit 1
fi

SUBJECT_DIR="$1"
MRIS_FILE="$2"

# Check if mris.txt exists
if [ ! -f "$MRIS_FILE" ]; then
    echo "Error: File '$MRIS_FILE' not found!"
    exit 2
fi

for sub in $(cat "$MRIS_FILE"); do
    echo "Processing subject: $sub"

    t1_img=$(find "$SUBJECT_DIR/$sub/run" -maxdepth 1 -type f -name "*_fov.nii.gz" | head -n 1)
    t1_brain="$SUBJECT_DIR/$sub/run/anat_brain.nii.gz"
    
    bet "$t1_img" "$t1_brain" -f 0.02 -g 0 -m -B
    
    fast -B -o "$SUBJECT_DIR/$sub/run/FAST" "$t1_brain"
    
    run_first_all -i "$t1_brain" -o "$SUBJECT_DIR/$sub/run/FIRST"
    
done
