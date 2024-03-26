report.html: report.Rmd code/05_render_report.R table1 figure1
	Rscript code/05_render_report.R

dataset:
	Rscript code/02_dataset.R

table1:
	Rscript code/03_table_one.R

figure1:
	Rscript code/04_figure_one.R

.PHONY: clean
clean:
	pwd
	rm -f output/table1.rds && rm -f output/figure1.rds && rm -f report.html
