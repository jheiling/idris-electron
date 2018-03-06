#!/bin/bash

idris --build electron.ipkg &&
idris --mkdoc electron.ipkg &&
idris --build example_main.ipkg &&
idris --build example_view.ipkg
