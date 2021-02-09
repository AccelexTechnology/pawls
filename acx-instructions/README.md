# Instructions for using PAWLS for annotation

1. Update `../api/config/configuration.json` to reflect the pdf labels you would like to collect.

2. Place the data you are planning to label in the `output_directory` defined in the configuration. The files must be in a nested format as described in the [main repo README](../README.md) so it might be necessary to use the script `./scripts/files_to_nested.sh`.

3. Preprocess the data (PAWLS cli must be installed), by running:

    ```bash
    pawls preprocess pdfplumber <output_directory>
    ```

4. Generate `$SHA_FILE` and `$NAME_FILE` using the script `./scripts/gen_shas.sh output_directory`. Ensure you only run this script once. This will gen files in the passed `output_directory`

5. Assign them to a user (locally this must be `development_user@example.com`) like:

    ```bash
    pawls assign $OUT_DIR development_user@example.com \
        --all \
        --sha-file "$OUT_DIR/sha.txt" \
        --name-file "$OUT_DIR/names.json"
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
