#!/bin/bash
#SBATCH --job-name=Lewislab_ATAC.%j.job
#SBATCH --partition=batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ad45368@uga.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=50gb
#SBATCH --time=48:00:00
#SBATCH --output=../MapATAC.%j.out
#SBATCH --error=../ATAC.%j.err


#### Identifying consensus peaks by IDR method

bam="${OUTDIR}/BamFiles/Shifted/*\.bam" #Don't forget the *

## 151_conidia37
# 151-N17_ATAC_H1mnGreen_37conidia_Rep2_shifted.marked.dupe.bam
# 151-N18_ATAC_H1mnGreen_37conidia_Rep3_shifted.marked.dupe.bam

## 151_hyphae
# 151-N1_ATAC_CEA10_WT__Rep1_shifted.marked.dupe.bam
# 151-N22_ATAC_CEA10_WT__Rep1_shifted.marked.dupe.bam

# 151-N6_Genomic_CEA10_WT__Rep1_shifted.marked.dupe.bam
# 154_N24_ATAC_gDNA_shifted.marked.dupe.bam

## conidia50
# 154_N25_ATAC_50C_conidia_rep1_shifted.marked.dupe.bam
# 154_N26_ATAC_50_conidia_rep2_shifted.marked.dupe.bam
# 154_N27_ATAC_50_conidia_rep3_shifted.marked.dupe.bam
# 154_N28_ATAC_50_conidia_rep4_shifted.marked.dupe.bam

## conidia37
# 154_N29_ATAC_37_conidia_rep1_shifted.marked.dupe.bam
# 154_N30_ATAC_37_conidia_rep2_shifted.marked.dupe.bam
# 154_N31_ATAC_37_conidia_rep3_shifted.marked.dupe.bam

## conidioph37
# 154_N32_ATAC_37_conidiophore_rep1_shifted.marked.dupe.bam
# 154_N33_ATAC_37_conidiophore_rep2_shifted.marked.dupe.bam
# 154_N34_ATAC_37_condiophore_rep3_shifted.marked.dupe.bam

## conidioph50
# 154_N35_ATAC_50_conidiophore_rep1_shifted.marked.dupe.bam
# 154_N36_ATAC_50_conidiophore_rep2_shifted.marked.dupe.bam
# 154_N37_ATAC_50_conidiophore_rep3_shifted.marked.dupe.bam

## hyphae50
# 154_N38_ATAC_50C_hyphae_rep1_shifted.marked.dupe.bam
# 154_N39_ATAC_50C_hyphae_rep2_shifted.marked.dupe.bam

# 154_N24_ATAC_gDNA_bampe_peaks.broadPeakpeaks.bed

##conidia50
# 154_N25_ATAC_50C_conidia_peaks.bed
# 154_N26_ATAC_50_conidia_peaks.bed
# 154_N27_ATAC_50_conidia_peaks.bed
# 154_N28_ATAC_50_conidia_peaks.bed

##conidia37
# 154_N29_ATAC_37_conidia_peaks.bed
# 154_N30_ATAC_37_conidia_peaks.bed
# 154_N31_ATAC_37_conidia_peaks.bed

##conidioph37
# 154_N32_ATAC_37_conidiophore_peaks.bed
# 154_N33_ATAC_37_conidiophore_peaks.bed
# 154_N34_ATAC_37_condiophore_peaks.bed

#conidioph50
# 154_N35_ATAC_50_conidiophore_peaks.bed
# 154_N36_ATAC_50_conidiophore_peaks.bed
# 154_N37_ATAC_50_conidiophore_peaks.bed

## hyphae50
# 154_N38_ATAC_50C_hyphae_peaks.bed
# 154_N39_ATAC_50C_hyphae_peaks.bed

## Use bedtools to make a consensus peakset of peaks with 80% overlap in all samples
ml BEDTools/2.31.1-GCC-13.3.0

bedtools intersect -a ${PeakDir}/151-N1_ATAC_CEA10_WT__Rep1_bampe_peaks.broadPeak -b ${PeakDir}/151-N22_ATAC_CEA10_WT__Rep1_bampe_peaks.broadPeak  -f 0.5 -wa > ${PeakDir}/151_Hyphae37_consensus.bed
bedtools intersect -a ${PeakDir}/151-N17_ATAC_H1mnGreen_37conidia_Rep2_bampe_peaks.broadPeak -b ${PeakDir}/151-N18_ATAC_H1mnGreen_37conidia_Rep3_bampe_peaks.broadPeak -f 0.5 -wa > ${PeakDir}/151_Conidia37_consensus.bed
bedtools intersect -a ${PeakDir}/154_N30_ATAC_37_conidia_rep2_bampe_peaks.broadPeak -b ${PeakDir}/154_N31_ATAC_37_conidia_rep3_bampe_peaks.broadPeak -f 0.5 -wa > ${PeakDir}/Conidia37_consensus.bed

bedtools intersect -a ${PeakDir}/154_N24_ATAC_gDNA_bampe_peaks.broadPeak -b ${PeakDir}/151-N6_Genomic_CEA10_WT__Rep1_bampe_peaks.broadPeak -f 0.5 -wa > ${PeakDir}/gDNA_consensus.broadPeak
bedtools intersect -a ${PeakDir}/154_N25_ATAC_50C_conidia_rep1_bampe_peaks.broadPeak -b ${PeakDir}/154_N26_ATAC_50_conidia_rep2_bampe_peaks.broadPeak ${PeakDir}/154_N27_ATAC_50_conidia_rep3_bampe_peaks.broadPeak -f 0.5 -wa > ${PeakDir}/Conidia50_consensus.broadPeak

bedtools intersect -a ${PeakDir}/154_N32_ATAC_37_conidiophore_rep1_bampe_peaks.broadPeak -b ${PeakDir}/154_N33_ATAC_37_conidiophore_rep2_bampe_peaks.broadPeak  -f 0.5 -wa > ${PeakDir}/Conidiophore37_consensus.broadPeak
bedtools intersect -a ${PeakDir}/154_N35_ATAC_50_conidiophore_rep1_bampe_peaks.broadPeak -b ${PeakDir}/154_N36_ATAC_50_conidiophore_rep2_bampe_peaks.broadPeak ${PeakDir}/154_N37_ATAC_50_conidiophore_rep3_bampe_peaks.broadPeak -f 0.5 -wa > ${PeakDir}/Conidiophore50_consensus.broadPeak


## report no. peaks in each peakfile
wc -l * > peak_counts.txt


## for each peakfile, calculate peak coverage
GENOME_SIZE=41037538

for f in *; do
    awk -v file="$f" -v gsize="$GENOME_SIZE" '
        $3 > $2 { sum += ($3 - $2) }
        END {
            pct = (sum / gsize) * 100
            printf "%s\t%d\t%.4f%%\n", file, sum, pct
        }
    ' "$f"
done
