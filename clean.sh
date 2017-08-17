#!/bin/bash

echo cleaning main...
idris --clean main.ipkg

echo cleaning view...
idris --clean view.ipkg
