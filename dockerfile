FROM rocker/r-ubuntu as base

# Creating project directory
RUN mkdir /final_project
WORKDIR /final_project

RUN mkdir -p renv
COPY renv.lock .
COPY .Rprofile .
COPY renv/activate.R renv
COPY renv/settings.json renv

# Create a cache directory for renv and set the cache path
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=/final_project/renv/.cache

# Restore the R environment
RUN R -e "renv::restore()"

# Start a new build stage to keep the final image clean
FROM rocker/r-ubuntu


# Install necessary system dependencies
RUN apt-get update && apt-get install -y pandoc

# Set the working directory
WORKDIR /final_project

# Copy everything from the base image
COPY --from=base /final_project .

# Create necessary directories
RUN mkdir code output data

# Copy project files
COPY data /final_project/data
COPY code /final_project/code
COPY Makefile .
COPY report.Rmd .

# Making report and moving it to shared folder
CMD make && mv report.html report
