# NextGenerationSequencingAnalysis
Preprocessed human genomic data: Dataset hg-38, using the GATK pipeline:
1. Data quality control: checking quality of dataset using FASTQC tool --> 2 report files are SRR062634_1_final_fastqc.html and SRR062634_2_final_fastqc.html
2. Remove bad reads: using Trimmomatic tools
3. Gene Alignments (to compare a sequence to a reference geneome to know that read belongs to which part of the gene, this is the Backbone of NGS): using BWA and HISAT2
   <img width="1059" height="309" alt="image" src="https://github.com/user-attachments/assets/85c3ecd3-58dc-4c20-9ac3-aecb8317f116" />

5.  
duplicate removal, BQSR, and variant calling from aligned and processed BAM files to
produce VCF files
