# data550_final_project

## Jack Alperstein

### Data 550 - Final Project 4: organization and GitHub repository

## Installation

To synchronize the R environment to run this project, follow these steps:

1. Clone this repository to your local machine.
2. Ensure that you have R and the `renv` package installed.
3. Navigate to the project directory in your terminal and run `make install`.

This will set up the R environment exactly as it was when the project was last developed, using the `renv.lock` file to ensure consistency.


1.  How to generate the final report and a brief description of the contents of the report

    -   Run the git bash command `make report.html` and the report will generate. The code to create report.html is the first item on the Makefile and all dependent objects and code are contained in the makefile. The contents are a table which details demographic information about our study population and a chart that details the number of daily ER visits in the study.

2.  Table Code

    -   The code for creating the required table is located in **code/03_table_one.R**

3.  Figure Code

    -   The code for creating the required figure is located in **code/04_figure_one.R**
