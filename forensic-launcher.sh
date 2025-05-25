#!/bin/bash

while true; do
    clear
    echo "====== Forensic Toolkit Launcher ======"
    echo "1) dc3dd (Disk Imaging)"
    echo "2) Autopsy (GUI Forensic Browser)"
    echo "3) Sleuthkit Tools (fls, icat, etc)"
    echo "4) Foremost (File Carving)"
    echo "5) ExifTool (Metadata Extraction)"
    echo "6) Wireshark (Network Analysis)"
    echo "7) Bulk Extractor (Artifact Extraction)"
    echo "8) Dumpzilla (Browser Analysis)"
    echo "9) LibreOffice (Report Writing)"
    echo "10) Exit"
    echo

    read -p "Select a tool by number: " choice

    case $choice in
    1) # dc3dd - Disk Imaging
        read -p "Enter source disk (e.g., /dev/sdX): " source_disk
        read -p "Enter output image file (e.g., /path/to/image.dd): " output_image
        read -p "Enter hash type (e.g., sha256, md5): " hash_type
        sudo dc3dd if="$source_disk" of="$output_image" hash="$hash_type" log=dc3dd-log.txt
        ;;
    
    2) # Autopsy - GUI Forensic Browser
        autopsy &
        ;;
    
    3) # Sleuthkit Tools
        read -p "Enter image file path: " image
        if [ ! -f "$image" ]; then
            echo "Error: File not found."
        else
            echo ">> Detecting partitions using mmls..."
            mmls "$image"
            echo
            read -p "Enter start sector of the partition to analyze: " offset
            echo ">> Listing files with fls (offset = $offset)..."
            fls -o "$offset" "$image"
            echo
            read -p "Do you want to extract a file using icat? (y/n): " extract
            if [[ "$extract" == "y" || "$extract" == "Y" ]]; then
                read -p "Enter inode number of the file to extract: " inode
                read -p "Enter output file name: " outfile
                icat -o "$offset" "$image" "$inode" > "$outfile"
                echo "File extracted as $outfile"
            fi
        fi
        ;;
    
    4) # Foremost - File Carving
        read -p "Enter image file path: " img
        foremost -i "$img" -o output_foremost
        ;;
    
    5) # ExifTool - Metadata Extraction
        read -p "Enter file to analyze: " file
        exiftool "$file"
        ;;
    
    6) # Wireshark - Network Analysis
        sudo wireshark &
        ;;
    
    7) # Bulk Extractor - Artifact Extraction
        read -p "Enter image file: " image
        sudo bulk_extractor -o bulk_out "$image"
        ;;
    
    8) # Dumpzilla - Browser Analysis
        read -p "Enter Firefox profile folder name (e.g., mxpv5djm.default-esr): " profile
        fullpath="$HOME/.mozilla/firefox/$profile"
        if [ ! -d "$fullpath" ]; then
            echo "Error: Profile directory not found at $fullpath"
        else
            sudo python3 ~/Desktop/Dumpzilla/dumpzilla.py "$fullpath"
        fi
        ;;
    
    9) # LibreOffice - Report Writing
        libreoffice &
        ;;
    
    10) # Exit
        echo "Exiting..."
        exit
        ;;
    
    *) # Invalid choice
        echo "Invalid choice!"
        ;;
    esac

    echo
    read -p "Press Enter to continue..." dummy
done
