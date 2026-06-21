# Linux Monitoring Project

A Bash-based monitoring tool for Linux systems that collects and logs system health metrics and error information.

## Overview

This project provides automated monitoring of key Linux system components including logs, network connectivity, disk usage, and hardware metrics. The main script aggregates system data and stores it in organized log files for analysis and troubleshooting.

## Contents

- `monitoramento-sistema.sh` - Main monitoring script
- `monitoramento_logs_sistema.txt` - System logs containing error and warning entries
- `monitoramento_logs_auth.txt` - Authentication logs with login failures and access denials
- `monitoramento_disco.txt` - Disk usage monitoring data
- `monitoramento_hardware.txt` - Hardware resource metrics (RAM, CPU, disk I/O)
- `monitoramento_rede.txt` - Network connectivity status

## Functionality

### System Logs Monitoring (`monitorar_logs`)
Extracts and logs error conditions from system logs:
- Searches `/var/log/syslog` for failed processes and errors
- Searches `/var/log/auth.log` for authentication failures and unauthorized access attempts
- Records timestamps and relevant error messages

### Network Monitoring (`monitorar_rede`)
Checks network connectivity:
- Tests internet connectivity via ping to 8.8.8.8
- Verifies HTTP connectivity to external services (e.g., Alura)
- Logs connectivity status with timestamps

### Disk Usage Monitoring (`monitorar_disco`)
Monitors disk space consumption:
- Identifies partitions with usage above 70%
- Records disk usage statistics
- Monitors specific directory usage (e.g., `/home/natdev`)

### Hardware Monitoring (`monitorar_hardware`)
Tracks system resource utilization:
- RAM usage (total, used, available)
- CPU usage percentage
- Disk read/write operations (I/O statistics)

## Usage

Run the monitoring script:
```bash
bash monitoramento_sistema.sh
```

The script creates a `monitoramento_sistema/` directory and stores all output files there.

## Output

All monitoring data is written to timestamped log files in the `monitoramento_sistema/` directory, enabling historical tracking of:
- System errors and warnings
- Network connectivity events
- Disk space trends
- Hardware performance metrics

## Requirements

- Bash shell
- Standard Linux utilities: `grep`, `awk`, `ping`, `curl`, `df`, `du`, `free`, `top`, `iostat`
- Appropriate file permissions to read `/var/log/` files
