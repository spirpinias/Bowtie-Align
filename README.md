# Bowtie2

Align sequence reads with Bowtie2. Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences. It is particularly good at aligning reads of about 50 up to 100s of characters to relatively long (e.g. mammalian) genomes.

https://github.com/BenLangmead/bowtie2

## Input

**Fastq files** 

In the **data** directory, single or paired end sequencing files in fastq format, optionally gzipped. 

**Genome Index Directory**

A genome index generated by Bowtie2, including the following 6 files:

- Index
   - sampleA.1.bt2
   - sampleA.2.bt2
   - sampleA.3.bt2
   - sampleA.4.bt2
   - sampleA.rev.1.bt2
   - sampleA.rev.2.bt2

If a reference directory is not supplied, it is inferred by the location of \*.rev.1.bt2

## App Panel Parameters 

### Main
Threads: 
- Choose your number of threads, if none selected default is all available on the machine. 

Pattern Forward, Pattern Reverse: 
- Pattern of the forward and reverse read matching suffix and file extension of your sequencing file. 
   - In the event of Single End - SampleA_R1.fastq.gz
      - Use Forward - "_R1.fastq.gz"
   - In the event of Paired End - SampleA_R1.fastq.gz SampleA_R2.fastq.gz
      - Use Forward - "_R1.fastq.gz" and Reverse - "_R2.fastq.gz"

Skip Number of Reads: 
- Skip first *X* reads from your sequencing files

Trim Bases from 5 Prime: 
- Trim *X* nucleotides from 5 prime of reads. 

Trim Bases from 3 Prime: 
- Trim *X* nucleotides from 3 prime of reads. 

Alignment Modes: 
- Alignment modes with presets available, the Auxiliary parameters will be ignored. If "Custom" is chosen, auxilliary parameters may be set. See [presets](https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#preset-options-in---end-to-end-mode) for more information. In general, very-fast and fast are intended to trade speed for sensitivity while sensitive and very sensitive will run more slowly, but will be more sensitive. Anything with "-local" will not attempt to align reads end to end, they can have soft clippped regions at the start and end of the read. 

### Auxiliary
Max Consecutive Seed Extension Attempts:
- Up to \<int\> consecutive seed extension attempts can "fail" before Bowtie 2 moves on, using the alignments found so far (-D, default 15)

Maximum Attempts to Reseed: 
- The maximum number of times Bowtie 2 will "re-seed" reads with repetitive seeds. When "re-seeding," Bowtie 2 simply chooses a new set of reads (same length, same number of mismatches allowed) at different offsets and searches for more alignments. A read is considered to have repetitive seeds if the total number of seed hits divided by the number of seeds that aligned at least once is greater than 300. (-R, default 2)

Number of Mismatches Allowed During Seed Alignment: 
- Sets the number of mismatches to allowed in a seed alignment during multiseed alignment. Can be set to 0 or 1. Setting this higher makes alignment slower (often much slower) but increases sensitivity (-N, default 0)

Length of the Seed Substrings to Align:
- Sets the length of the seed substrings to align during multiseed alignment. Smaller values make alignment slower but more sensitive. (-L, default 22 for end to end and 20 for local)

Function Governing the Interval Between Seed Substrings:
- For instance, specifying S,1,2.5 sets the interval function f to f(x) = 1 + 2.5 * sqrt(x), where x is the read length. (-i, default S,1,0.75)
   
Local: 
- In this mode, Bowtie 2 does not require that the entire read align from one end to the other. Rather, some characters may be omitted ("soft clipped") from the ends in order to achieve the greatest possible alignment score. By default, Bowtie uses --end-to-end. (--local)

## Output

- In your **results** folder you will find your .bam alignment file with prefix same as sequencing files. 

## Source

https://github.com/BenLangmead/bowtie2

## Cite

Langmead B, Wilks C, Antonescu V, Charles R. Scaling read aligners to hundreds of threads on general-purpose processors. Bioinformatics. 2018 Jul 18. doi: 10.1093/bioinformatics/bty648.

Langmead B, Salzberg SL. Fast gapped-read alignment with Bowtie 2. Nature Methods. 2012 Mar 4;9(4):357-9. doi: 10.1038/nmeth.1923.

Langmead, B., Trapnell, C., Pop, M. et al. Ultrafast and memory-efficient alignment of short DNA sequences to the human genome. Genome Biol 10, R25 (2009). https://doi.org/10.1186/gb-2009-10-3-r25
