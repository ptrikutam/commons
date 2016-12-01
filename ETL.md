# Green Commons ETL

## Introduction

These are the Extract-Transform-Load (ETL)
scripts for importing books and other resources
into the Green Commons database.

We are using the `kiba` gem
to set up ETL pipelines.

[`kiba`]: https://github.com/thbar/kiba

## Usage

Start by bundling the gems needed:

```
bundle install
```

Then run the script to import the records,
transform them,
and load them into the database:

```
bundle exec kiba convert-islandpress.etl
```

## Components

### Island Press epubs on S3


