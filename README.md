# Forensic_Data_Analysis




Installation Instructions for Forensic Toolkit

Follow these steps to install all the required tools on Kali Linux or any Debian-based system:

1. Update the System
sudo apt update
2. Install Required Forensic Tools from APT
sudo apt install -y \
  dc3dd \
  autopsy \
  sleuthkit \
  foremost \
  bulk-extractor \
  libimage-exiftool-perl \
  wireshark \
  libreoffice \
  git \
  python3

3. Install Dumpzilla from GitHub

git clone https://github.com/Busindre/Dumpzilla.git
cd Dumpzilla
chmod +x dumpzilla.py

You can now run Dumpzilla with:
python3 dumpzilla.py /path/to/firefox/profile
