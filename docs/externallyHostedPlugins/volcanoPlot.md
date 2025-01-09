# Volcano Plot

> ENDPOINT: [https://scidap.com/vp/volcano](https://scidap.com/vp/volcano)

The volcano plot is a SciDAP developed and hosted plugin for a fully customizeable volcano plot (used with deseq/diffbind/manorm2/single-cell cwls).




## Redirect Link Data

When used with the ```queryRedirect``` plugin, there are 4 required query params, and many optional ones (all form values can be included in query params).

### Required Params

- ```data_file```: a download link to the (tsv) data file for plotting
- ```data_col_name```: name of the column in the tsv that is distinct per data point
- ```x_col```: name of column in tsv for x-axis plotting (assume log2 values)
- ```y_col```: name of column in tsv for y-axis plotting (assumes pvalue/padj with max of value 1)
  - assumes log10 values
  - axis is reversed (largest values at bottom)
  - smallest plotable value is 1e-308


The download link for the ```data_file``` param (and access to other input/output values) can be accessed via the ```this.getSampleValue``` method.  

This method follows JS string formatting syntax with backticks ``` ` ``` and ```${}```.

The first param of that method is ```'inputs'``` or ```'outputs'```.  
The second param is the fieldName of that input or output.
If the field is a file, then the method will automatically format that file into a download link.