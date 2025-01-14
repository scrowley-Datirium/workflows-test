cwlVersion: v1.0
class: Workflow


requirements:
  - class: SubworkflowFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement
  - class: MultipleInputFeatureRequirement


'sd:upstream':
  sample_to_filter:
    - "deseq.cwl"


inputs:

  alias:
    type: string
    label: "Experiment short name/Alias"
    sd:preview:
      position: 1

  feature_file:
    type: File
    format: "http://edamontology.org/format_3475"
    label: "DESeq experiment run for genes"
    doc: "TSV file with differentially expressed genes from DESeq pipeline"
    'sd:upstreamSource': "sample_to_filter/diff_expr_file"
    'sd:localLabel': true

  sql_query:
    type: string
    label: "Filtering parameters"
    doc: "Filtering parameters (WHERE parameters for SQL query)"
    'sd:filtering':
      params:
        columns: ["RefseqId", "GeneId", "Chrom", "TxStart", "TxEnd", "Strand", "RpkmCondition1", "RpkmCondition2", "baseMean", "log2FoldChange", "pvalue", "padj"]
        types:   ["string", "string", "string", "number", "number", "string", "number", "number", "number", "number", "number", "number"]

  header:
    type: boolean?
    default: false
    label: "Include header line"
    doc: "Print header line in the output file"
    'sd:layout':
      advanced: true

  columns:
    type:
    - "null"
    - string[]
    default: ["Chrom AS chrom", "TxStart AS start", "TxEnd AS end", "GeneId AS name", "log2FoldChange AS score", "Strand AS strand"]
    label: "Columns to print"
    doc: |
      List of columns to print (SELECT parameters for SQL query).
      Need to have format [chrom start end name score strand]. No header.
      4th columns should be unique, so we use GeneId for that.
      5th columns will be ignored by Tag Density pipeline, so we use log2FoldChange.
    'sd:layout':
      advanced: true


outputs:

  filtered_file:
    type: File
    format: "http://edamontology.org/format_3003"
    label: "Filtered differentially expressed genes"
    doc: "Regions of interest formatted as headerless BED file with [chrom start end name score strand]"
    outputSource: feature_select/filtered_file
    'sd:visualPlugins':
    - syncfusiongrid:
        tab: 'Filtering results'
        Title: 'Filtered table'

  filtering_stdout_log:
    type: File
    format: "http://edamontology.org/format_2330"
    label: "Filtering stdout log"
    doc: "Filtering stdout log"
    outputSource: feature_select/stdout_log

  filtering_stderr_log:
    type: File
    format: "http://edamontology.org/format_2330"
    label: "Filtering stderr log"
    doc: "Filtering stderr log"
    outputSource: feature_select/stderr_log


steps:

  feature_select:
    run: ../tools/feature-select-sql.cwl
    in:
      feature_file: feature_file
      sql_query: sql_query
      columns:
        source: columns
        valueFrom: $(self.join(", "))
      header: header
    out:
    - filtered_file
    - stdout_log
    - stderr_log


$namespaces:
  s: http://schema.org/

$schemas:
- https://github.com/schemaorg/schemaorg/raw/main/data/releases/11.01/schemaorg-current-http.rdf

s:name: "Filter differentially expressed genes from DESeq for Tag Density Profile Analyses"
label: "Filter differentially expressed genes from DESeq for Tag Density Profile Analyses"
s:alternateName: "Filter differentially expressed genes from DESeq for Tag Density Profile Analyses"

s:downloadUrl: https://raw.githubusercontent.com/datirium/workflows/master/workflows/filter-deseq-for-heatmap.cwl
s:codeRepository: https://github.com/datirium/workflows
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: Common Workflow Language
  s:url: http://commonwl.org/

s:creator:
- class: s:Organization
  s:legalName: "Cincinnati Children's Hospital Medical Center"
  s:location:
  - class: s:PostalAddress
    s:addressCountry: "USA"
    s:addressLocality: "Cincinnati"
    s:addressRegion: "OH"
    s:postalCode: "45229"
    s:streetAddress: "3333 Burnet Ave"
    s:telephone: "+1(513)636-4200"
  s:logo: "https://www.cincinnatichildrens.org/-/media/cincinnati%20childrens/global%20shared/childrens-logo-new.png"
  s:department:
  - class: s:Organization
    s:legalName: "Allergy and Immunology"
    s:department:
    - class: s:Organization
      s:legalName: "Barski Research Lab"
      s:member:
      - class: s:Person
        s:name: Michael Kotliar
        s:email: mailto:misha.kotliar@gmail.com
        s:sameAs:
        - id: http://orcid.org/0000-0002-6486-3898


doc: |
  Filters differentially expressed genes from DESeq for Tag Density Profile Analyses
  ==================================================================================

  Tool filters output from DESeq pipeline run for genes to create a file with regions
  of interest for Tag Density Profile Analyses.
