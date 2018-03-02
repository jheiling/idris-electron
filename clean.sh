#!/bin/bash

echp cleaning package
idris --clean electron.ipkg

echo cleaning example main...
idris --clean example_main.ipkg

echo cleaning example view...
idris --clean example_view.ipkg
