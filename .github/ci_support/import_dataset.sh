#!/bin/bash
for ds in $(ls pyiron/calculation/*.tar.gz); do 
    cp ${ds} .
    cp calculation/export.csv .
    file=$(basename ${ds} .tar.gz)
    python << EOF
from pyiron_base import Project
Project("pyiron/calculation").unpack("${file}")
EOF
    rm $(basename ${ds})
    rm export.csv
done
