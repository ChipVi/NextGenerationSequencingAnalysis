#!/bin/bash

# NGS RNA-seq Pipeline
# Author: Chip Vi
# Description: End-to-end preprocessing NGS data

sudo apt install fastqc bwa samtools hisat2

fastqc SRR062634_1_final.fastq

java -jar trimmomatic-0.39.jar SE -threads 4 SRR062634_1_final.fastq.gz SRR062634_1_trimmed.fastq.gz TRAILING:10 -phred33

zcat SRR062634_1_final.fastq.gz

hisat2 -x hg38/genome -1 SRR062634_1_final.fastq.gz -2 SRR062634_2_final.fastq.gz --rg-id SRR062634 --rg "PL:ILLUMINA" --rg "SM:SRR062634" --rg "PU:HWI-EAS110_103327062.6.1" -S aligned.sam

samtools markdup -S final_sorted.bam marked_duplicates.bam

gatk BaseRecalibrator -I marked_duplicates.bam -R hg38.fa --known-sites Homo_sapiens_assembly38.dbsnp138.vcf -O recal_data.table

samtools faidx hg38.fa

gatk CreateSequenceDictionary R=hg38.fa O=hg38.dict

gatk HaplotypeCaller -R hg38.fa -I sorted_dedup_bqsr_reads.bam -O raw_variants.vcf

gatk VariantAnnotator -R hg38.fa -I sorted_dedup_bqsr_reads.bam -V raw_variants.vcf --dbsnp Homo_sapiens_assembly38.dbsnp138.vcf -O annotated_variants.vcf