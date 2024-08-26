#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
else
  echo "args:"
  for i in $*; do 
    echo $i 
  done
  echo ""
fi


# Bowtie2

## Searching for Index and Prefix.
index_file=$(find -L ../data -name "*.rev.1.bt2")
index_file_count=$(echo $index_file | wc -w)
index_file_name=$(basename -s .rev.1.bt2 $index_file)
index_dir_name=$(dirname $index_file)

## Searching for fastq sequencing files.
input_fwd_fastqs=$(find -L ../data -name "*$pattern_fwd")
file_count=$(echo $input_fwd_fastqs | wc -w)

some_fastq=$(find -L ../data -name "*.f*q*" | head -1)

if [ -z "${1}" ]; then
  num_thread=$(get_cpu_count)
else
  if [ "${1}" -gt $(get_cpu_count) ]; then
    echo "Requesting more threads than available. Setting to Max Available."
    num_thread=$(get_cpu_count)
  else
    num_thread="${1}"
  fi
fi

if [ -z "${2}" ]; 
then
  pattern_fwd="_$(get_read_pattern "$some_fastq" --fwd)"
else
  pattern_fwd="${2}"
fi

input_fwd_fastqs=$(find -L ../data -name "*$pattern_fwd")
file_count=$(echo $input_fwd_fastqs | wc -w)
index_file_count=$(echo $index_file | wc -w)

if [ -z "${3}" ]; 
then
  pattern_rev="_$(get_read_pattern "$some_fastq" --rev)"
else
  pattern_rev="${3}"
fi

if [ -z "${4}" ]; 
then
  skip_val=""
else
  skip_val="-s ${4}"
fi

if [ -z "${5}" ]; 
then
  trim_5=""
else
  trim_5="-5 ${5}"
fi

if [ -z "${6}" ]; 
then
  trim_3=""
else
  trim_3="-3 ${6}"
fi

if [ "${7}" == "Custom" ] || [ -z "${7}" ]; 
then
  align_mod=""
  echo "You are not using a preset!"
  #set custom parameters
  if [ -z "${8}" ]; 
  then
    max_seedExt=""
  else
    max_seedExt="-D ${8}"
  fi

  if [ -z "${9}" ]; 
  then
    max_reSeed=""
  else
    max_reSeed="-R ${9}"
  fi

  if [ -z "${10}" ]; 
  then
    num_mismatch=""
  else
    num_mismatch="-N ${10}"
  fi

  if [ -z "${11}" ]; 
  then
    len_seed=""
  else
    len_seed="-L ${11}"
  fi

  if [ -z "${12}" ]; 
  then
    func_seed=""
  else
    func_seed="-i ${12}"
  fi

  if [ -z "${13}" ] || [ "${13}" != "True" ]; 
  then
    local=""
  else
    local="--local"
  fi
else
  align_mod="--${7}"
  echo "You are using a preset: ${align_mod}!"
fi


