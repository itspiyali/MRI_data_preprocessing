"
FAST:
-----
FSL's 'fast' CLI tool can segment MRIs into Gray Matter(GM), White Matter(WM), Cerebro-Spinal Fluid(CSF). It 
Fast expects Skullstripped images
"
# For brain segmentation using FSL's 'bet':
bet </path/to/t1.nii.gz> </path/to/t1_skullstripped.nii.gz> -f 0.5 -g 0 -m -B
"
'-B' is for bias field correction
-f 0.5 is the threshold by which the skull is stripped, smaler value does more stripping
"

# For segmenting using 'fast':
fast -B -o <full/path/to/output/directory>/<Prefix> <t1_skullstripped.nii.gz> 
"
'Prefix' is the prefix for all segmented images
'-B' indicates the bias-corrected image 
"


"
FIRST:
------
FIRST is FSL’s tool for automatic segmentation of a number of subcortical structures. The supported structures are:

    Putamen (Puta)
    Caudate nucleus (Caud)
    Nucleus accumbens (Accu)
    Globus pallidus (Pall)
    Hippocampus (Hipp)
    Amygdala (Amyg)
    Thalamus (Thal)
    Brainstem (BrStem) 
"
run_first_all -i </full/path/to/output/directory> -o <full/path/to/output/directory>/<Prefix>
"


1. https://web.mit.edu/fsl_v5.0.10/fsl/doc/wiki/FAST.html
2. https://open.win.ox.ac.uk/pages/fslcourse/lectures/additional/2024/2-seg_part1.pdf
3. https://web.mit.edu/fsl_v5.0.10/fsl/doc/wiki/FIRST(2f)StepByStep.html
4. https://web.mit.edu/fsl_v5.0.10/fsl/doc/wiki/FIRST(2f)UserGuide.html
"
