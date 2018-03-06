#!/bin/bash

idris --clean electron.ipkg
idris --clean example_main.ipkg
idris --clean example_view.ipkg
rm -rf electron_doc
