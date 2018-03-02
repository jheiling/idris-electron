#!/bin/bash

echo building package
idris --build electron.ipkg
idris --mkdoc electron.ipkg

echo building example main...
idris --build example_main.ipkg

echo building example view...
idris --build example_view.ipkg
