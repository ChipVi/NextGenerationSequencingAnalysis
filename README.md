# NextGenerationSequencingAnalysis
Preprocessed human genomic data, using the GATK pipeline:
## 1. Data quality control:
   * Checking quality of dataset using FASTQC tool --> 2 report files are SRR062634_1_final_fastqc.html and SRR062634_2_final_fastqc.html
   * I also retrieve read group information from FASTQ metadata for the BAM files in GATK later.
## 2. Remove bad reads: 
   using Trimmomatic tools --> see file1_trimmed.gz
## 3. Gene Alignments 
   To compare a sequence to a reference geneome to know that read belongs to which part of the gene, this is the Backbone of NGS: using BWA and HISAT2
   <img width="1059" height="309" alt="image" src="https://github.com/user-attachments/assets/85c3ecd3-58dc-4c20-9ac3-aecb8317f116" />

   In this project, I use the reference genome hg38 downloaded from HISAT2 website.
  
   After that, we will have the SAM/BAM (Binary) file to store the results of the alignments. The SAM result looks like this:
   * in Notepad
     
      <img width="628" height="787" alt="image" src="https://github.com/user-attachments/assets/4182253a-565d-44f5-84df-c9539fab0ed9" />
      
   * for illustration:
      <img width="914" height="279" alt="image" src="https://github.com/user-attachments/assets/378a679b-5215-4441-bdda-48810b2839e2" />
   
   Due to the great size of the SAM file, I can not upload the full result of the aligned.sam file on here.

## 4. Marking Duplicates after Alignments: 
   using SAMTOOLS --> see mark_dup.bam 
## 5. Base Quality Score Recalibration (optional)
   Scoring system sometimes make mistakes in scoring base quality, so we need to use BQSR to adjust these scores.
   --> the result is stored in sorted_dedup_bqsr_reads.bam
## 6. Create index files of reference genome hg38.fa for GATK tools:
   * FASTA file hg38.fa.fai: so that GATK can quickly access position of the reference genome
       <img width="634" height="346" alt="image" src="https://github.com/user-attachments/assets/27806538-4b81-4a86-a9dc-448b3a7887c9" />

   * Dictionary file hg38.dict: so that GATK can understand the structure of the reference genome
       <img width="1421" height="360" alt="image" src="https://github.com/user-attachments/assets/c5537085-9a4d-4a47-be1b-2922a204500d" />
## 7. Variant Identification: 
   using HaplotypeCaller of GATK: mark the regions where the data is different (variant) from the reference genome.   
   --> the result is stored in raw_variants.vcf
   
   HaplotypeCaller of GATK works with all types of variants, but it works better with germline variants like SNP - single nucleotide polymorphisms and
   indels (insertions/deletions), not somatic/tumor variants.
   
   The example of the marked variants look like this:
   <img width="1911" height="639" alt="image" src="https://github.com/user-attachments/assets/fa2ecbb4-950e-4ff4-93d9-c92d9d9adfe8" />

   
   
