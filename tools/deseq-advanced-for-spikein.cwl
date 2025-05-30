cwlVersion: v1.0
class: CommandLineTool


requirements:
- class: InlineJavascriptRequirement


hints:
- class: DockerRequirement
  dockerPull: avivdemorgan/scidap-deseqspikein:v1.1.0


inputs:

  untreated_files:
    type:
      - File
      - File[]
    inputBinding:
      prefix: "-u"
    doc: |
      Untreated input CSV/TSV files

  treated_files:
    type:
      - File
      - File[]
    inputBinding:
      prefix: "-t"
    doc: |
      Treated input CSV/TSV files
  
  ercc_counts_treated:
    type:
      - File
      - File[]
    inputBinding:
      prefix: "-ter"
    doc: |
      Untreated input CSV/TSV files

  ercc_counts_untreated:
    type:
      - File
      - File[]
    inputBinding:
      prefix: "-uer"
    doc: |
      Untreated input CSV/TSV files

  untreated_name:
    type: string?
    inputBinding:
      prefix: "-un"
    doc: |
      Name for untreated condition, use only letters and numbers

  treated_name:
    type: string?
    inputBinding:
      prefix: "-tn"
    doc: |
      Name for treated condition, use only letters and numbers

  untreated_sample_names:
    type:
      - "null"
      - string
      - string[]
    inputBinding:
      prefix: "-ua"
    doc: |
      Unique aliases for untreated expression files. Default: basenames of -u without extensions

  treated_sample_names:
    type:
      - "null"
      - string
      - string[]
    inputBinding:
      prefix: "-ta"
    doc: |
      Unique aliases for treated expression files. Default: basenames of -t without extensions

  rpkm_cutoff:
    type: float?
    inputBinding:
      prefix: "-cu"
    doc: |
      Minimum threshold for rpkm filtering. Default: 5

  cluster_method:
    type:
    - "null"
    - type: enum
      symbols:
      - "row"
      - "column"
      - "both"
    inputBinding:
      prefix: "--cluster"
    doc: |
      Hopach clustering method to be run on normalized read counts for the
      exploratory visualization part of the analysis. Default: do not run
      clustering

  row_distance:
    type:
    - "null"
    - type: enum
      symbols:
      - "cosangle"
      - "abscosangle"
      - "euclid"
      - "abseuclid"
      - "cor"
      - "abscor"
    inputBinding:
      prefix: "--rowdist"
    doc: |
      Distance metric for HOPACH row clustering. Ignored if --cluster is not
      provided. Default: cosangle

  column_distance:
    type:
    - "null"
    - type: enum
      symbols:
      - "cosangle"
      - "abscosangle"
      - "euclid"
      - "abseuclid"
      - "cor"
      - "abscor"
    inputBinding:
      prefix: "--columndist"
    doc: |
      Distance metric for HOPACH column clustering. Ignored if --cluster is not
      provided. Default: euclid

  center_row:
    type: boolean?
    inputBinding:
      prefix: "--center"
    doc: |
      Apply mean centering for feature expression prior to running
      clustering by row. Ignored when --cluster is not row or both.
      Default: do not centered

  maximum_padj:
    type: float?
    inputBinding:
      prefix: "--padj"
    doc: |
      In the exploratory visualization part of the analysis output only features
      with adjusted P-value not bigger than this value. Default: 0.05

  batch_file:
    type: File?
    inputBinding:
      prefix: "-bf"
    doc: |
      Metadata file for multi-factor analysis. Headerless TSV/CSV file.
      First column - names from --ua and --ta, second column - batch name.
      Default: None

  output_prefix:
    type: string?
    inputBinding:
      prefix: "-o"
    doc: |
      Output prefix. Default: deseq

  threads_count:
    type: int?
    inputBinding:
      prefix: '-p'
    doc: |
      Run script using multiple threads


outputs:

  diff_expr_file:
    type: File
    outputBinding:
      glob: "*report.tsv"

  read_counts_file_all:
    type: File
    outputBinding:
      glob: "*counts_all.gct"

  read_counts_file_filtered:
    type: File
    outputBinding:
      glob: "*counts_filtered.gct"

  phenotypes_file:
    type: File
    outputBinding:
      glob: "*phenotypes.cls"

  plot_lfc_vs_mean:
    type: File?
    outputBinding:
      glob: "*_ma_plot.png"

  gene_expr_heatmap:
    type: File?
    outputBinding:
      glob: "*_expression_heatmap.png"

  plot_pca:
    type: File?
    outputBinding:
      glob: "*_pca_plot.png"

  plot_lfc_vs_mean_pdf:
    type: File?
    outputBinding:
      glob: "*_ma_plot.pdf"

  gene_expr_heatmap_pdf:
    type: File?
    outputBinding:
      glob: "*_expression_heatmap.pdf"

  plot_pca_pdf:
    type: File?
    outputBinding:
      glob: "*_pca_plot.pdf"

  mds_plot_html:
    type: File?
    outputBinding:
      glob: "*_mds_plot.html"
    doc: |
      MDS plot of normalized counts. Optionally batch corrected
      based on the --remove value.
      HTML format

  stdout_log:
    type: stdout

  stderr_log:
    type: stderr

  error_msg:
    type: File?
    outputBinding:
      glob: "error_msg.txt"

  error_report:
    type: File?
    outputBinding:
      glob: "error_report.txt"

baseCommand: [/usr/local/bin/run_deseq_for_spikein.R]
stdout: deseq_stdout.log
stderr: deseq_stderr.log

$namespaces:
  s: http://schema.org/

$schemas:
- https://github.com/schemaorg/schemaorg/raw/main/data/releases/11.01/schemaorg-current-http.rdf

s:mainEntity:
  $import: ./metadata/deseq-metadata.yaml

s:name: "deseq-advanced-for-spikein"
s:downloadUrl: https://raw.githubusercontent.com/Barski-lab/workflows/master/tools/deseq-advanced-for-spikein.cwl
s:codeRepository: https://github.com/Barski-lab/workflows
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: Common Workflow Language
  s:url: http://commonwl.org/

s:creator:
- class: s:Organization
  s:legalName: "Datirium LLC"
  s:location:
  - class: s:PostalAddress
    s:addressCountry: "USA"
    s:addressLocality: "Cincinnati"
    s:addressRegion: "OH"
    s:postalCode: ""
    s:streetAddress: ""
    s:telephone: ""
  s:logo: "https://avatars.githubusercontent.com/u/33202955?s=200&v=4"
  s:department:
  - class: s:Organization
    s:legalName: "Datirium LLC"
    s:department:
    - class: s:Organization
      s:legalName: "Bioinformatics"
      s:member:
      - class: s:Person
        s:name: Robert Player
        s:email: mailto:support@datirium.com
        s:sameAs:
        - id: https://orcid.org/0000-0001-5872-259X

doc: |
  Tool runs DESeq/DESeq2 script similar to the original one from BioWArdrobe.
  Expected input counts have already been normalized via a spike-in.
  DESeq internal normalization has been disabled in the baseCommand script call

  untreated_files and treated_files input files should have the following header (case-sensitive)
  <RefseqId,GeneId,Chrom,TxStart,TxEnd,Strand,TotalReads,Rpkm>         - CSV
  <RefseqId\tGeneId\tChrom\tTxStart\tTxEnd\tStrand\tTotalReads\tRpkm>  - TSV

  Format of the input files is identified based on file's extension
  *.csv - CSV
  *.tsv - TSV
  Otherwise used CSV by default

  The output file's rows order corresponds to the rows order of the first CSV/TSV file in
  the untreated group. Output is always saved in TSV format

  Output file includes only intersected rows from all input files. Intersected by
  RefseqId, GeneId, Chrom, TxStart, TxEnd, Strand

  DESeq/DESeq2 always compares untreated_vs_treated groups.
  Normalized read counts and phenotype table are exported as GCT and CLS files for GSEA downstream analysis.


s:about: |
  usage: /Users/kot4or/workspaces/cwl_ws/workflows/tools/dockerfiles/scripts/run_deseq.R
        [-h] -u UNTREATED [UNTREATED ...] -t TREATED [TREATED ...]
        [-ua [UALIAS ...]] [-ta [TALIAS ...]] [-un UNAME] [-tn TNAME]
        [-bf BATCHFILE] [-cu CUTOFF] [--padj PADJ]
        [--cluster {row,column,both}]
        [--rowdist {cosangle,abscosangle,euclid,abseuclid,cor,abscor}]
        [--columndist {cosangle,abscosangle,euclid,abseuclid,cor,abscor}]
        [--center] [-o OUTPUT] [-d DIGITS] [-p THREADS]

  Run BioWardrobe DESeq/DESeq2 for untreated-vs-treated groups (condition-1-vs-
  condition-2)

  options:
    -h, --help            show this help message and exit
    -u UNTREATED [UNTREATED ...], --untreated UNTREATED [UNTREATED ...]
                          Untreated (condition 1) CSV/TSV isoforms expression
                          files
    -t TREATED [TREATED ...], --treated TREATED [TREATED ...]
                          Treated (condition 2) CSV/TSV isoforms expression
                          files
    -ua [UALIAS ...], --ualias [UALIAS ...]
                          Unique aliases for untreated (condition 1) expression
                          files. Default: basenames of -u without extensions
    -ta [TALIAS ...], --talias [TALIAS ...]
                          Unique aliases for treated (condition 2) expression
                          files. Default: basenames of -t without extensions
    -un UNAME, --uname UNAME
                          Name for untreated (condition 1), use only letters and
                          numbers
    -tn TNAME, --tname TNAME
                          Name for treated (condition 2), use only letters and
                          numbers
    -bf BATCHFILE, --batchfile BATCHFILE
                          Metadata file for multi-factor analysis. Headerless
                          TSV/CSV file. First column - names from --ualias and
                          --talias, second column - batch group name. Default:
                          None
    -cu CUTOFF, --cutoff CUTOFF
                          Minimum threshold for rpkm filtering. Default: 5
    --padj PADJ           In the exploratory visualization part of the analysis
                          output only features with adjusted P-value not bigger
                          than this value. Default: 0.05
    --cluster {row,column,both}
                          Hopach clustering method to be run on normalized read
                          counts for the exploratory visualization part of the
                          analysis. Default: do not run clustering
    --rowdist {cosangle,abscosangle,euclid,abseuclid,cor,abscor}
                          Distance metric for HOPACH row clustering. Ignored if
                          --cluster is not provided. Default: cosangle
    --columndist {cosangle,abscosangle,euclid,abseuclid,cor,abscor}
                          Distance metric for HOPACH column clustering. Ignored
                          if --cluster is not provided. Default: euclid
    --center              Apply mean centering for feature expression prior to
                          running clustering by row. Ignored when --cluster is
                          not row or both. Default: do not centered
    -o OUTPUT, --output OUTPUT
                          Output prefix. Default: deseq
    -d DIGITS, --digits DIGITS
                          Precision, number of digits to print. Default: 3
    -p THREADS, --threads THREADS
                          Threads
