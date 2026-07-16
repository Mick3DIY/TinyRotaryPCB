#!/bin/bash
# TinyRotaryPCB with KiCad and KiKit plugin for PCB panelization
# GitHub project : https://github.com/Mick3DIY/TinyRotaryPCB
# KiCad documentation : https://www.kicad.org
# KiKit plugin documentation : https://github.com/yaqwsx/KiKit

# Input and output files
INPUT_FILE="TinyRotaryPCB.kicad_pcb"
OUTPUT_DIR="panel"
OUTPUT_FILE="${OUTPUT_DIR}/TinyRotaryPCB_panel.kicad_pcb"

# Layout parameters, by default 2x2 -> panelize.sh <rows> <cols> parameters
LAYOUT_ROWS=${1:-2}
LAYOUT_COLS=${2:-2}
LAYOUT_SPACE="2mm"

# Tab parameters
TAB_TYPE="fixed"
TAB_HWIDTH="2mm"
TAB_VWIDTH="2mm"
TAB_VCOUNT="2"

# Cuts parameters
CUTS="mousebites; drill: 0.5mm; spacing: 0.75mm; offset: -0.3mm; prolong: 0.5mm"

# Framing parameters
FRAME_TYPE="railstb"
FRAME_WIDTH="2mm"
FRAME_SPACE="2mm"

# Text parameters
TEXT_HEIGHT="0.8mm"
TEXT_VOFFSET_POS="1mm"
TEXT_VOFFSET_NEG="-1mm"
TEXT_JUSTIFY="hjustify: center; vjustify: center;"
POST_MILLRADIUS="1mm"

# Ensure output directory exist
mkdir -p "$OUTPUT_DIR"

# Kikit command with all parameters
kikit panelize \
    --layout "grid; rows: ${LAYOUT_ROWS}; cols: ${LAYOUT_COLS}; space: ${LAYOUT_SPACE}" \
    --tabs "${TAB_TYPE}; hwidth: ${TAB_HWIDTH}; vwidth: ${TAB_VWIDTH}; vcount: ${TAB_VCOUNT}" \
    --cuts "${CUTS}" \
    --framing "${FRAME_TYPE}; width: ${FRAME_WIDTH}; space: ${FRAME_SPACE};" \
    --text "simple; text: {boardTitle} {boardRevision} ${LAYOUT_COLS}x${LAYOUT_ROWS}; anchor: mt; voffset: ${TEXT_VOFFSET_POS}; height: ${TEXT_HEIGHT}; ${TEXT_JUSTIFY}" \
    --text2 "simple; text: Created on {boardDate}; anchor: mb; voffset: ${TEXT_VOFFSET_NEG}; height: ${TEXT_HEIGHT}; ${TEXT_JUSTIFY}" \
    --post "millradius: ${POST_MILLRADIUS}" \
    "$INPUT_FILE" "$OUTPUT_FILE"

# Check if the command succeeded
if [ $? -eq 0 ]; then
    echo "Panelization successful : $OUTPUT_FILE"
else
    echo "Error : Panelization failed"
    exit 1
fi
