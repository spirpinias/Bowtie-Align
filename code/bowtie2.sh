#!/usr/bin/env bash

set -ex

source ./config.sh
source ./utils.sh

echo "Using threads : $num_thread"
echo "Sequencing Read R1 Fastqs: $input_fwd_fastqs"

if [ "$index_file_count" -ne 1 ];
then
  echo "Please ensure your data directory contains 1 indexed genome."
  exit 1
fi

# Aligning Sequencing Reads.
if [ "$file_count" -ge 1 ];
then
  
  for input_fwd_fastq in $input_fwd_fastqs
  do
  
    file_prefix=$(sed "s/$pattern_fwd//" <<< $input_fwd_fastq)
    file_prefix=$(basename $file_prefix)
    input_rev_fastq=$(get_reverse_file "$input_fwd_fastq")

    if [ -z $input_rev_fastq ]; then
      echo "Aligning Single End Reads."
      read_flags="-U ${input_fwd_fastq}"
    else
       echo "Aligning Paired End Reads."   
      read_flags="-1 ${input_fwd_fastq} -2 ${input_rev_fastq}"
    fi

    bowtie2 --no-unal \
      ${align_mod} \
      ${max_reSeed} \
      ${max_seedExt} \
      ${num_mismatch} \
      ${func_seed} \
      ${len_seed} \
      ${skip_val} \
      ${trim_5} \
      ${trim_3} \
      ${local} \
      -p "${num_thread}" \
      -x "${index_dir_name}/${index_file_name}" ${read_flags} | samtools view -b - > ../results/"$file_prefix".bam
  done
else
  echo "No Sequencing Reads Found!"
fi