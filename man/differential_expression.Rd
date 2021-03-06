% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diff_expression.R
\name{differential_expression}
\alias{differential_expression}
\title{Analyze Differential Features}
\usage{
differential_expression(
  experiment,
  data_type = c("tss", "tsr", "tss_features", "tsr_features"),
  comparison_name,
  comparison_type,
  comparison,
  shrink_lfc = FALSE
)
}
\arguments{
\item{experiment}{TSRexploreR object.}

\item{data_type}{Whether the input was generated from TSSs ('tss') or TSRs ('tsr').}

\item{comparison_name}{The name given to the comparison when stored back into the TSRexploreR object.}

\item{comparison_type}{For DEseq2, either 'contrast' or 'name'. For edgeR, either 'contrast' or 'coef'.}

\item{comparison}{For DESeq2, the contrast or name. For edgeR, the coefficients or contrasts.}

\item{shrink_lfc}{For DESeq2, whether the log2 fold changes are shrunk (TRUE) or not (FALSE).}
}
\value{
TSRexploreR object with results for given contrast.
}
\description{
Find differential TSSs or TSRs from previously generated edgeR or DESeq2 model.
}
\details{
Calculatse the differential TSSs or TSRs for the desired contrast.
'comparison_type' corresponds to the way the comparison will be performed,
  with edgeR having the 'contrast' and 'coef' options,
  and DESeq2 having the 'contrast' and 'name' options.
The actual contrast is specified with 'comparison',
  the format of which should match with the option provided to 'comparison_type'.
If DESeq2 is used and 'shrink_lfc' is TRUE,
  apeglm is used to shrink the Log2 fold changes to mitigate the effect size of
  genes with lower levels of expression.
The results for the contrast will be stored back into the TSRexploreR object with
  the name provided to 'comparison_name'.
}
\examples{
data(TSSs)
sample_sheet <- data.frame(
  sample_name=c(
    sprintf("S288C_D_\%s", seq_len(3)),
    sprintf("S288C_WT_\%s", seq_len(3))
  ),
  file_1=rep(NA, 6), file_2=rep(NA, 6),
  condition=c(
    rep("Diamide", 3),
    rep("Untreated", 3)
  )
)

exp <- TSSs \%>\%
  tsr_explorer(sample_sheet=sample_sheet) \%>\%
  format_counts(data_type="tss")

# Differential TSSs with DESeq2.
exp <- fit_de_model(exp, data_type="tss", formula=~condition, method="edgeR")

exp <- differential_expression(
  exp, data_type="tss", 
  comparison_name="Diamide_vs_Untreated",
  comparison_type="coef",
  comparison=2
)

}
\seealso{
\code{\link{fit_de_model}} to fit DEseq2 or edgeR model to data.
}
