## Info
Scripts for processing hmqs series
## Usage
```bash
# pull nmr files and calculate values for referencing
source 01-600_scp-spectra-pull.sh
# calculate time stamps
bash 02-600_expno-time-WT-hours.sh
# extract peak heights and assign them to time stamps
bash 03-600-data-height-WT.sh
```
