#!/bin/bash

echo building main...
idris --build main.ipkg

echo building view...
idris --build view.ipkg
