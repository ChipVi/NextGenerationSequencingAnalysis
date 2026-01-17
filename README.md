# NextGenerationSequencingAnalysis
Preprocessed human genomic data, using the GATK pipeline:
1. Data quality control: checking quality of dataset using FASTQC tool --> 2 report files are SRR062634_1_final_fastqc.html and SRR062634_2_final_fastqc.html
   I also retrieve read group information from FASTQ metadata for the BAM files in GATK later.
2. Remove bad reads: using Trimmomatic tools --> see file1_trimmed.gz
3. Gene Alignments (to compare a sequence to a reference geneome to know that read belongs to which part of the gene, this is the Backbone of NGS): using BWA and HISAT2
   <img width="1059" height="309" alt="image" src="https://github.com/user-attachments/assets/85c3ecd3-58dc-4c20-9ac3-aecb8317f116" />

   In this project, I use the reference genome hg38 downloaded from HISAT2 website.
  
   After that, we will have the SAM/BAM (Binary) file to store the results of the alignments. The SAM result looks like this:
      + in Notepad
      <img width="628" height="787" alt="image" src="https://github.com/user-attachments/assets/4182253a-565d-44f5-84df-c9539fab0ed9" />
      + for illustration:
      <img width="914" height="279" alt="image" src="https://github.com/user-attachments/assets/378a679b-5215-4441-bdda-48810b2839e2" />
   Due to the great size of the SAM file, I can not upload the full result of the aligned.sam file on here.

4. Marking Duplicates after Alignments: using SAMTOOLS --> see mark_dup.bam 
5. BQSR
6. Variant calling 
