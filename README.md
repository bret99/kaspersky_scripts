# Kaspersky Security Center Incident Response Script Kit (KSC-IRKit)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Platform Support](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue?style=flat-square)](https://github.com/username/ksc-irkit)

An Enterprise-grade suite of optimized Incident Response (IR) and forensic collection scripts tailored for automated deployment via **Kaspersky Security Center (KSC)**. This toolkit enables security operations teams to rapidly gather geolocation data, file system states, and persistence mechanisms across heterogeneous environments.

---

## 🚀 Value Proposition & Capabilities

When a security incident occurs, speed and consistency of triage data collection are critical. `KSC-IRKit` bridges the gap between central endpoint management and forensic analysis:

* **Unified KSC Delivery:** Fully structured wrappers (`.bat` for Windows hosts, `.sh` for Unix/macOS) designed to bypass execution policies and comply with KSC task execution parameters.
* **Geolocation Intelligence:** Instant mapping of compromised assets using IP-to-Geolocation APIs (`gug*` modules).
* **Forensic Auditing:** Deep-dive file system indexing and metadata parsing into structured JSON reports (`guf*` modules).
* **Persistence Mechanism Extraction:** Comprehensive automated auditing of Windows Task Scheduler, Autoruns, and Unix Cron jobs (`gusa*` modules).
* **Automated Exfiltration:** Direct, secure data exfiltration via pre-configured SMTP protocols straight to the SOC mailbox.

---

## 📋 Prerequisites

Before deploying the tasks via KSC, ensure the following configurations are established:

1. **API Key:** A valid `ip2geolocation` API key is required for network triage modules.
2. **SMTP Credentials:** Valid credentials for your internal or secure exfiltration email server:
   * `EMAIL_FROM/Sender`: Sender address.
   * `EMAIL_FROM_PASS/PasswordPlain`: Sender authorization key/password.
   * `EMAIL_TO/Recipient`: Target SOC / Security Analyst mailbox.
   * `FileExtension`: Files extension to get.
   * `SourceDir`: Directory of files extension to get.

---

## 🛠️ Module Nomenclature

The toolkit uses a strict, predictable naming convention:
* `gug*` / `gbh*` — Geolocation & Network Triage Utilities
* `guf*` — File System State Observers (JSON Output)
* `gufe*` — Files Getter (Archive Output)
* `gusa*` — Persistence & Auto-start Analysts

| Platform | Module Prefix | Script Extension | Launch Wrapper | Target OS |
| :--- | :--- | :--- | :--- | :--- |
| **Windows** | `gugw` / `gufw` / `gusaw` /`gufew` | `.ps1` | `.bat` | Windows Client/Server |
| **Linux** | `gugl` / `gbhl` | `.sh` | `.sh` | Ubuntu, RHEL, CentOS, etc. |
| **macOS** | `gbhm` / `gbhm`| `.sh` | `.sh` | macOS |

---

## 🚀 Quick Start & KSC Deployment Guide

### Deployment on Windows via KSC

To ensure PowerShell execution policies do not block remote execution, always leverage the provided batch wrappers.

1. Open **Kaspersky Security Center Console**.
2. Navigate to **Tasks** -> **Create a Task** -> **Advanced** -> **Run script / executable**.
3. When prompted to upload scripts, select **Import whole directory**. 
4. **CRITICAL:** Select the specific isolated subdirectory containing *only* the required `.bat` and `.ps1` files for that specific task to prevent unnecessary payload distribution.
5. Set the executable line to point to the respective `.bat` file:
   ```cmd
   .\*.bat
   ```

### Deployment on Unix / macOS via KSC

1. Create a **Run script** task targeting Unix managed hosts.
2. Ensure execution bits are set if deploying manually, or allow KSC to invoke the shell interpreter directly:
   ```bash
   chmod +x ./*.sh
   ./*.sh
   ```

---

## ⚙️ Configuration & Customization

Before packaging scripts for production, modify the configuration block inside the core scripts or environment definitions with your corporate tokens:

```bash
# Configuration block example inside the script
export API="your_secure_api_key_here"
export EMAIL_FROM="soc-alerts@enterprise.com"
export EMAIL_FROM_PASS="ComplexSecurePassword123!"
export EMAIL_TO="ir-triage@enterprise.com"
```

---

## 💎 Support the Project

If this tool helps protect your infrastructure, consider supporting the developer! 

### Crypto Wallets
| Asset | Network | Address |
| :--- | :--- | :--- |
| **BTC** | Bitcoin | `bc1qjwl80sv06xj2yhumn6k6xemchryem923wwts5x` |
| **USDT / ETH** | Ethereum (ERC20) | `0xc01b996c7b08ccfad463f27e54f1e74e6ac6f9ff` |
| **USDT / SOL** | Solana | `D7a5CdLaDwkKehnH82y6VJEF3hADWuupuhWCXecHvEnt` |
| **TON** | TON Network | `UQBhPLwdFiJdh6sZ96sZfxrxD9Lu6NFtaUecWeoHSM-EPc0P` |
| **LTC** | Litecoin | `ltc1qkm58ks5kuc64rjwd74sfalc5xsn7h6sr4vt45w` |
| **SOL** | Solana | `D7a5CdLaDwkKehnH82y6VJEF3hADWuupuhWCXecHvEnt` |

---

📜 License

This project is licensed under the MIT License - see the LICENSE file for details.
