# Example of VisualPlugins on workflow outputs

The keyword `'sd:visualPlugins'` enables SciDAP visualization plugins. 

The `line`, `pie`, `chart`, `igvbrowser`, `syncfusiongrid`, and `linkList` types are already available in the platform.

> Examples:
- [Example of VisualPlugins on workflow outputs](#example-of-visualplugins-on-workflow-outputs)
  - [Scatter plot example](#scatter-plot-example)
  - [Redirect with query](#redirect-with-query)
  - [Line chart example](#line-chart-example)
  - [Box plot example](#box-plot-example)
  - [Pie chart example](#pie-chart-example)
  - [Scatter plot 3D example](#scatter-plot-3d-example)
  - [Comparetable example](#comparetable-example)
  - [Syncfusiongrid example](#syncfusiongrid-example)
  - [igvBrowser example](#igvbrowser-example)
  - [Markdown view example](#markdown-view-example)
  - [Image example](#image-example)
  - [Table View](#table-view)
  - [Link List example](#link-list-example)


## Scatter plot example


```yaml
...

outputs:
    ...
  atdp_result:
    type: File
    label: "ATDP results"
    format: "http://edamontology.org/format_3475"
    doc: "Average Tag Density generated results"
    outputSource: average_tag_density/result_file
    'sd:visualPlugins':
    - scatter:
        tab: 'QC Plots'
        Title: 'Average Tag Density'
        xAxisTitle: 'Distance From TSS (bases)'
        yAxisTitle: 'Average Tag Density (per bp)'
        colors: ["#b3de69"] # list of single color to use for plot points
        height: 500 # width of plots is flexed based on amount. height can be set (plots can be opened in full screen)
        data: [$1, $2] # index of columns from file to use (starts at 1)
        comparable: "atdp"
```

---


## Redirect with query



<!-- > see [externally hosted visual plugins](TODO) for more -->

```yaml
    ...
  outputs:  
    diff_expr_file: 
        type: File
        label: "Differentially expressed features grouped by isoforms, genes or common TSS"
        format: "http://edamontology.org/format_3475"
        doc: "DESeq generated file of differentially expressed features grouped by isoforms, genes or common TSS in TSV format"
        outputSource: deseq/diff_expr_file
        'sd:visualPlugins':
            ...
        - queryRedirect:
            tab: "Overview" # will be included in "Quick View" links if tab="Overview"
            label: "Link to interactive Volcano Plot" # what the link will say
            url: "https://scidap.com/vp/volcano" # endpoint for externally hosted plugin 
            
            # JS string to format
            query_eval_string: "`data_file=${this.getSampleValue('outputs', 'diff_expr_file')}&data_col_name=GeneId&x_col=log2FoldChange&y_col=padj`" 

    ...
  
```

The ```query_eval_string``` is meant to be the query that tells the external plugin what data to use.  
For more information on data expected by scidap plugins (given in ```url``` field), [see here](../externallyHostedPlugins/)  
The ```this.getSampleValue``` method is available for this plugin to use in order
follow JS string formatting syntax with backticks ``` ` ``` and ```${}```.

---


## Line chart example

```yaml
...

outputs:
    ...
    fastx_statistics:
        type: File
        label: "FASTQ statistics"
        format: "http://edamontology.org/format_2330"
        doc: "fastx_quality_stats generated FASTQ file quality statistics file"
        outputSource: fastx_quality_stats/statistics_file
        'sd:visualPlugins':
        - line:
            Title: 'Base frequency plot' # title of plot
            xAxisTitle: 'Nucleotide position' # label of axis
            yAxisTitle: 'Frequency'
            colors: ["#b3de69", "#99c0db", "#fb8072", "#fdc381", "#888888"] # default colors used
            data: [$12, $13, $14, $15, $16] #which columns to include (first column is 1)
```

---

## Box plot example

```yaml
...

outputs:
    ...
    fastx_statistics_after:
    type: File
    label: "FASTQ statistics"
    format: "http://edamontology.org/format_2330"
    doc: "fastx_quality_stats generated FASTQ file quality statistics file"
    outputSource: fastx_quality_stats_after/statistics_file
    'sd:visualPlugins':
    - boxplot:
        tab: 'QC Plots'
        Title: 'After Clipper Quality Control'
        xAxisTitle: 'Nucleotide position'
        yAxisTitle: 'Quality score'
        colors: ["#b3de69", "#888888", "#fb8072", "#fdc381", "#99c0db"] # index of color correlates to index in file
        data: [$11, $7, $8, $9, $12] #index of columns to use (starts at 1)
```

---

## Pie chart example

Pie charts are generally included on a sample preview (sample-card when for listing samples in a project)

For adding a plugin to the preview card, the ```'sd:visualPlugin'``` key is prepended with a ```'sd:preview'``` keyword

```yaml
...

outputs:
    ...

  get_formatted_stats:
    type: File?
    label: "Bowtie, STAR and GEEP mapping stats"
    format: "http://edamontology.org/format_2330"
    doc: "Processed and combined Bowtie & STAR aligner and GEEP logs"
    outputSource: get_stat/collected_statistics_tsv
    'sd:preview':
      'sd:visualPlugins':
      - pie:
          colors: ['#b3de69', '#99c0db', '#fdc381', '#fb8072', '#778899']
          data: [$2, $3, $4, $5, $6]
```

---


## Scatter plot 3D example

```yaml
...

outputs:
    ...
  pca_file:
    type: File
    format: "http://edamontology.org/format_3475"
    label: "PCA analysis scores results"
    doc: "PCA analysis scores results exported as TSV"
    outputSource: pca/pca_scores_file
    'sd:visualPlugins':
    - scatter3d:
        tab: '3D Plots'
        Title: 'PCA'
        xAxisTitle: 'PCA1'
        yAxisTitle: 'PCA2'
        zAxisTitle: 'PCA3'
        colors: ["#b3de69", "#888888", "#fb8072"]
        height: 600
        data: [$1, $2, $3, $4]
```

---

## Comparetable example

Is an addon to other plugins that allow that plugin to be used on the sample-comparison page.  
Is compatable with the ```scatter``` and ```line``` plugin.  
> The scatter plot needs 2 data values to be usable in the comparetable.
> The line plot needs 1 data vlue to be usable in the comparetable

<!-- > (more verbose version of this plugin available with [syncfusion grids](#syncfusiongrid-example)) -->

```yaml
...
outputs:
    ...
    gene_body_report:
        type: File?
        format: "http://edamontology.org/format_3475"
        label: "Gene body average tag density plot for all isoforms longer than 1000 bp"
        doc: "Gene body average tag density plot for all isoforms longer than 1000 bp in TSV format"
        outputSource: get_gene_body/gene_body_report_file
        'sd:visualPlugins':
        - line:
            tab: 'QC Plots'
            Title: 'Gene body average tag density plot'
            xAxisTitle: "Gene body percentile (5' -> 3')"
            yAxisTitle: "Average Tag Density (per percentile)"
            colors: ["#232C15"]
            data: [$2]
            comparable: "gbatdp"

    ...
    insert_size_report:
        type: File
        label: "Insert size distribution report"
        format: "http://edamontology.org/format_3475"
        doc: "Insert size distribution report (right after alignment and sorting)"
        outputSource: get_bam_statistics/ext_is_section
        'sd:visualPlugins':
        - scatter:
            tab: 'QC Plots'
            Title: 'Insert Size Distribution'
            xAxisTitle: 'Insert size'
            yAxisTitle: 'Pairs total'
            colors: ["#4b78a3"]
            height: 500
            data: [$1, $2]
            comparable: "isdp"
    
    ...

```

---

## Syncfusiongrid example

Displays file as excel sheet. Includes filtering options for better comparisons.

```yaml
...

outputs:
    ...
    diff_expr_file:
        type: File
        label: "DESeq results, TSV"
        format: "http://edamontology.org/format_3475"
        doc: "DESeq generated list of differentially expressed items grouped by isoforms, genes or common TSS"
        outputSource: deseq/diff_expr_file
        'sd:visualPlugins':
        - syncfusiongrid:
            Title: 'Combined DESeq results'
            tab: 'custom tab name'
    ...
```

---

## igvBrowser example

Displays bam/bigwig for exploratory visualization.

```yaml
...

outputs:
    ...
    bigwig:
        type: File
        format: "http://edamontology.org/format_3006"
        label: "BigWig file"
        doc: "Generated BigWig file"
        outputSource: bam_to_bigwig/bigwig_file
        'sd:visualPlugins':
        - igvbrowser:
            id: 'igvbrowser'
            type: 'wig'
            name: "BigWig Track"
            height: 120
    ...
```

---

## Markdown view example

```yaml
...

outputs:
    ...
    samplesheet_md:
        type: File
        label: "Samplesheet with condition labels"
        doc: "Samplesheet with condition labels"
        outputSource: run_rnbeads_diff/samplesheet_overview
        'sd:visualPlugins':
        - markdownView:
            tab: 'Overview'
```

---

## Image example

```yaml
...

outputs:
    ...
    mbias_plot_png:
        type: File[]
        label: "Methylation bias plot (PNG)"
        doc: "QC data showing methylation bias across read lengths"
        format: "http://edamontology.org/format_3603"
        outputSource: bismark_extract_methylation/mbias_plot_png
        'sd:visualPlugins':
        - image:
            tab: 'Plots'
            Caption: 'Methylation bias plot'
```

---

## Table View

The tableView plugin allows a SINLGE tsv (and yaml) file to be used for creating a QC-table in sample-comparison.

```yaml
outputs: 
    ...
    get_stat_formatted_log:
        type: File?
        label: "Bowtie & Samtools Rmdup combined formatted log"
        format: "http://edamontology.org/format_3475"
        doc: "Processed and combined Bowtie aligner and Samtools rmdup formatted log"
        outputSource: get_stat/collected_statistics_tsv
        'sd:visualPlugins':
        - tableView:
            vertical: true
            tab: 'Overview'
```

There are 2 important things to note.

1. the **tableView** plugin also requires a yaml file (both generated from any **get_statistic_...** tools)
2. the yaml file should be saved as an output. It's name is irrelevant, but the output name from the get_statistic tool used should end in "yaml" (not "yml")

---

## Link List example

Allows generated html files to be served by satellites and opened within or outside of the platform.

```yaml
...

outputs:
    ...
    volcano_plot_html_file:
        type: File
        outputSource: make_volcano_plot/html_file
        label: "Volcano Plot"
        doc: |
            HTML index file with volcano plot data.
        'sd:visualPlugins':
        - linkList:
            tab: 'Overview'
            target: "_blank" # target: "_this" should cause page to be opened within a component on the platform
```

---

<!-- ## MA plot example


```yaml
...

outputs:
    ...
    diff_expr_features:
        type: File
        outputSource: deseq_multi_factor/diff_expr_features
        label: "TSV file with not filtered differentially expressed features"
        doc: |
            TSV file with not filtered differentially expressed features
        'sd:visualPlugins':
        - MAplot:
            tab: "MA plot" # can be own tab, or in "Plots"
            Title: "Differentially expressed features"
            data: ["$1", "$7", "$8"] # col for:   feature, baseMean, log2FC
            xAxisTitle: "Mean Expression (log[x])"
            yAxisTitle: "log 2 Fold Change"
            height: 500,
            colors: ["#b3de69"]
    ...
``` -->
