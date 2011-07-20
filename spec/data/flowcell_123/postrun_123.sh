# processing unaligned
mkdir -p /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/all
# 1 fastq files found in /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Project_123
cat /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Project_123/Sample_1/1_NoIndex_L001_R1_001.fastq.gz > /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/all/s_1_1_NoIndex.fastq.gz
# Creating path: /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/filter
mkdir -p /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/filter
zcat /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/all/s_1_1_NoIndex.fastq.gz | /solexa/bin/illuminati/bin/fastq_filter.rb | gzip -c > /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/filter/s_1_1_NoIndex.fastq.gz
# distributing unaligned fastq.gz files
# custom barcode splitting
# running fastqc
cd /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/filter; /solexa/bin/scripts/fastqc.pl -v --files "*.fastq.gz"
cd /solexa/bin/illuminati
# distributing fastqc directory
# processing export files
mkdir -p /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/all
# 1 export files found in /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123
cat /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123/Sample_1/1_NoIndex_L001_R1_001_export.txt.gz > /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/all/s_1_1_NoIndex_export.txt.gz
# distributing export files
# distributing aligned stats files
mkdir -p /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
wkhtmltopdf /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.htm /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.pdf
cp /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.pdf /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/Demultiplex_Stats.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123/Summary_Stats_FC/Barcode_Lane_Summary.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123/Summary_Stats_FC/Sample_Summary.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
# Error: file not found:/solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123.
# distributing to qcdata
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
# Creating directory /solexa/bin/illuminati/spec/sandbox/flowcell_123/InterOp
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123/InterOp
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/InterOp /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/RunInfo.xml /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/Events.log /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
# Creating directory /solexa/bin/illuminati/spec/sandbox/flowcell_123/reports
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123/reports
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/Data/reports /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
# Creating directory /solexa/bin/illuminati/spec/sandbox/flowcell_123/Basecall_Stats_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123/Basecall_Stats_123
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123 /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
wkhtmltopdf /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.htm /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.pdf
cp /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/IVC.pdf /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/Basecall_Stats_123/Demultiplex_Stats.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123/Summary_Stats_FC/Barcode_Lane_Summary.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
cp /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Project_123/Summary_Stats_FC/Sample_Summary.htm /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123
# Error: file not found:/solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123.
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/Aligned/Summary_Stats_123 /solexa/bin/illuminati/spec/sandbox/flowcell_123
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123
# Creating directory /solexa/bin/illuminati/spec/sandbox/flowcell_123/fastqc
mkdir -p /solexa/bin/illuminati/spec/sandbox/flowcell_123/fastqc
cp -r /solexa/bin/illuminati/spec/data/flowcell_123/Unaligned/filter/fastqc /solexa/bin/illuminati/spec/sandbox/flowcell_123