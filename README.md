# NextGenerationSequencingAnalysis
Preprocessed human genomic data, using GATK pipeline on BASH cmd:
* Full pipeline source code: see pipeline.sh
* Virtual Memory Extension on Linux (Swap File method): see virtual_RAM.sh
  
## 1. Data Quality Control:
   * Checking quality of dataset using FASTQC tool --> 2 report files are SRR062634_1_final_fastqc.html and SRR062634_2_final_fastqc.html
   * Remove bad reads: 
   using Trimmomatic tools --> see file1_trimmed.gz
## 2. Gene Alignments into SAM, and Preprocess on BAM
   To compare a sequence to a reference geneome to know that read belongs to which part of the gene, this is the Backbone of NGS: using BWA and HISAT2
   <img width="1059" height="309" alt="image" src="https://github.com/user-attachments/assets/85c3ecd3-58dc-4c20-9ac3-aecb8317f116" />

   In this project, I use the reference genome hg38 downloaded from HISAT2 website and use HISAT2 tool for alignments.
  
   After that, we will have the SAM file to store the results of the alignments. The SAM result looks like this:
   * in Notepad
     
      <img width="1918" height="377" alt="image" src="https://github.com/user-attachments/assets/dc6865a6-13ac-4ee1-9f16-e743b18712a4" />
      
   * for illustration in UGene application:
      <img width="914" height="279" alt="image" src="https://github.com/user-attachments/assets/378a679b-5215-4441-bdda-48810b2839e2" />

  Note parameter details in SAM files:
  
  <img width="1812" height="748" alt="image" src="https://github.com/user-attachments/assets/421b3cc4-0919-4c3a-bad4-bc4d1ad54ad8" />

   Due to the great size of the SAM file, I can not upload the full result of the aligned.sam file on here.

Then we can convert the SAM file into BAM file for reduced storage and preprocess on the BAM files. 
  - **sorting alignments** using SAMTOOLS based on gene-coordinates.
  - fix mate-pair information. In pair-end sequencing, each end in the same pair is called a mate. We do **fixmate** so that each mate (each ends) know the information of the other end. 
  - **mark Duplicates**: During reading process, a sequence can be read multiple times due to PCR fragments are amplified or when a fragment is read multiple times. THerefore, we flag/mark duplicate read. (We DO NOT REMOVE THEM because it will lose the integrity of the BAM file).
   using SAMTOOLS --> see mark_dup.bam 
  - **Base Quality Score Recalibration BQSR** (optional)
   Scoring system sometimes make mistakes in scoring base quality, early cycles have higher late cycles. So we need to use BQSR to adjust these scores based on standard reference variants VCF file.

    To do this first we need to create index files of reference genome hg38.fa for GATK tools:
     * FASTA Index file hg38.fa.fai: so that GATK can quickly access position of the reference genome
       <img width="634" height="346" alt="image" src="https://github.com/user-attachments/assets/27806538-4b81-4a86-a9dc-448b3a7887c9" />
     * Dictionary file hg38.dict: so that GATK can understand the structure of the reference genome
       <img width="1421" height="360" alt="image" src="https://github.com/user-attachments/assets/c5537085-9a4d-4a47-be1b-2922a204500d" />

       
==> the final result is stored in *sorted_dedup_bqsr_reads.bam*
       
## 3. Variants Identification (Building VCF file): 
  * Tool HaplotypeCaller of GATK: mark the regions where the data is different (variant) from the reference genome.   
   --> the result is stored in raw_variants.vcf
   
   HaplotypeCaller of GATK works with all types of variants, but it works better with germline variants like SNP - single nucleotide polymorphisms and indels (insertions/deletions), not somatic/tumor variants.
## 4. Variants Annotate
Using the GATK Variant Annotator to mark the known variants (rsID). In variants we have found, we compare them with a database to define which variants are new and which are known (rsIDs). The database I use in this project is the **dbSNP138**.

   The example of the marked variants look like this:
   <img width="1911" height="639" alt="image" src="https://github.com/user-attachments/assets/fa2ecbb4-950e-4ff4-93d9-c92d9d9adfe8" />

   
   
