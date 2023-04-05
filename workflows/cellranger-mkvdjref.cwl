cwlVersion: v1.0
class: Workflow


requirements:
  - class: SubworkflowFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement
  - class: MultipleInputFeatureRequirement


inputs:

  alias:
    type: string
    label: "Experiment short name/Alias"
    sd:preview:
      position: 1

  genome_fasta_file:
    type: File
    label: "Genome FASTA file. Hard/soft-masked files are not allowed."
    doc: |
      Genome FASTA file. Hard/soft-masked files are not allowed.
      For example:
      https://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

  annotation_gtf_file:
    type: File
    label: "GTF annotation file. Should include gene_biotype/transcript_biotype fields."
    doc: |
      GTF annotation file. Should include gene_biotype/transcript_biotype fields.
      For example:
      https://ftp.ensembl.org/pub/current_gtf/homo_sapiens/Homo_sapiens.GRCh38.108.gtf.gz


outputs:

  indices_folder:
    type: Directory
    outputSource: cellranger_mkvdjref/indices_folder
    label: Cell Ranger V(D)J genome indices
    doc: |
      Cell Ranger V(D)J-compatible reference folder.
      This folder will include V(D)J segment FASTA file.

  stdout_log:
    type: File
    outputSource: cellranger_mkvdjref/stdout_log
    label: stdout log generated by cellranger mkvdjref
    doc: |
      stdout log generated by cellranger mkvdjref

  stderr_log:
    type: File
    outputSource: cellranger_mkvdjref/stderr_log
    label: stderr log generated by cellranger mkvdjref
    doc: |
      stderr log generated by cellranger mkvdjref


steps:

  extract_fasta:
    run: ../tools/extract-7z.cwl
    in:
      file_to_extract: genome_fasta_file
      output_filename:
        default: "annotation.fasta"
    out:
    - extracted_file

  extract_gtf:
    run: ../tools/extract-7z.cwl
    in:
      file_to_extract: annotation_gtf_file
      output_filename:
        default: "annotation.gtf"
    out:
    - extracted_file

  cellranger_mkvdjref:
    run: ../tools/cellranger-mkvdjref.cwl
    in:
      genome_fasta_file: extract_fasta/extracted_file
      annotation_gtf_file: extract_gtf/extracted_file
      output_folder_name:
        default: "cellranger_vdj_ref"
    out:
    - indices_folder
    - stdout_log
    - stderr_log


$namespaces:
  s: http://schema.org/

$schemas:
- https://github.com/schemaorg/schemaorg/raw/main/data/releases/11.01/schemaorg-current-http.rdf

label: "Cell Ranger Build V(D)J Reference Indices"
s:name: "Cell Ranger Build V(D)J Reference Indices"
s:alternateName: "Build a Cell Ranger V(D)J-compatible reference folder from a user-supplied genome FASTA and gene GTF files"

s:downloadUrl: https://raw.githubusercontent.com/Barski-lab/workflows-datirium/master/workflows/cellranger-mkvdjref.cwl
s:codeRepository: https://github.com/Barski-lab/workflows-datirium
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
  Cell Ranger Build V(D)J Reference Indices
  
  Build a Cell Ranger V(D)J-compatible reference folder from
  a user-supplied genome FASTA and gene GTF files.