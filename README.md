# raidmon

A lightweight SMART monitoring utility for Linux servers with hardware RAID controllers.

`raidmon` discovers physical disks behind hardware RAID controllers, collects and normalises SMART data, stores complete snapshots as JSON, detects missing or unexpected devices, and provides concise health reports suitable for cron-based monitoring.

The project is intentionally simple:

* Python 3 only
* No database
* No web interface
* No Docker
* Minimal dependencies
* Human-readable output
* Machine-readable JSON
* Designed to remain maintainable for years

## Features

* Automatic discovery of RAID controllers and physical disks
* SMART collection from disks behind hardware RAID
* Complete SMART snapshot export as JSON
* Preservation of raw SMART output
* Normalised fields for monitoring and analysis
* Detection of missing devices
* Detection of unmanaged devices
* Simple OK/WARN/FAIL status model
* Suitable for cron and automation

## Requirements

* Linux
* Python 3
* smartmontools (`smartctl`)
* sg3_utils (`sg_map`)
* lsscsi

Example:

```bash
sudo apt install smartmontools sg3-utils lsscsi
```
## Installation

```bash
sudo apt update
sudo apt install build-essential git python3 smartmontools sg3-utils lsscsi

git clone https://github.com/oa-evseev/raidmon.git
cd raidmon

sudo make install
```

Generate the initial configuration:

```bash
sudo raidmon build-config
```

## Configuration

Generate the initial configuration:

```bash
sudo raidmon build-config
```

This command discovers:

* RAID controllers
* Physical disks
* Device topology
* Required external utilities

and writes a configuration file.

By default:

```text
/etc/raidmon/config.json
```

To recreate the configuration:

```bash
sudo raidmon build-config --force
```

## Commands

### Collect a summary

```bash
sudo raidmon collect
```

Example:

```text
OK    sg1  W6A0KA70  36C  10513h
OK    sg2  W6A0YYF7  35C  10516h
OK    sg3  W6A0WPTA  34C  10521h
```

### Export full JSON

```bash
sudo raidmon collect --json > snapshot.json
```

The JSON output contains:

* controller information
* device topology
* parsed SMART data
* raw SMART output
* health evaluation

### Check for problems

```bash
sudo raidmon check
```

Only warnings and failures are displayed.

Exit codes:

| Code | Meaning |
| ---- | ------- |
| 0    | OK      |
| 1    | WARN    |
| 2    | FAIL    |

This makes the command suitable for cron jobs and monitoring scripts.

## Status Rules

### FAIL

* SMART health status is not PASSED
* Current Pending Sector count is greater than zero
* Offline Uncorrectable count is greater than zero
* Expected device is missing
* SMART data cannot be collected

### WARN

* Reallocated Sector count is greater than zero
* Temperature exceeds configured limits
* Unmanaged device detected

### OK

* No problems detected

## Design Philosophy

`raidmon` is a data collection tool first.

The primary goal is to collect and preserve as much useful SMART information as possible while avoiding false alarms. The tool intentionally uses conservative health rules and stores complete raw SMART output for future analysis.

## License

Licensed under the GNU General Public License v3.0 (GPL-3.0).

