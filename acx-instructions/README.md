# Instructions for using PAWLS for annotation

1. Update `../api/config/configuration.json` to reflect the pdf labels you would like to collect.

2. Place the data you are planning to label in the `output_directory` defined in the configuration.

3. Preprocess the data (PAWLS cli must be installed), by running:

```bash
pawls preprocess grobid <output_directory>
```

4. TODO: generate `$SHA_FILE` and `$NAME_FILE`.

5. Assign them to a user (locally this must be `development_user@example.com`) like:

```bash
pawls assign <output_directory> development_user@example.com \
    --all \
    --sha-file $SHA_FILE
    --name-file $NAME_FILE
```

6. Run the app with `docker-compose up --build` from the root directory and annotate the documents.

7. Export the annotations to coco format. From the root dir run:

```bash
pawls export <output_directory> ./api/config/configuration.json \
    <annotation_output_dir> \
    coco \
    --no-export-images \  # optional: this prevents generation of an image for each page of the doc
    # --include-unfinished  # optional: ideally this shouldn't be used as the annotators should
                            # mark docs as finished after annotation is complete
```