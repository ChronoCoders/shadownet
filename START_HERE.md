# 🚀 ZKDIP - Quick Start Guide

## Zero-Knowledge Dedicated IP VPN System

### Quick Start

**Windows:**
```cmd
start.bat
```

**Linux/Mac:**
```bash
chmod +x start.sh
./start.sh
```

---

## Menu Options

### 1️⃣ **Start All Services**
Launches all four services in separate windows:
- Blind Token Service (Port 3001)
- Enclave Simulator (Port 3002)
- DIP Service (Port 3003)
- VPN Server (Port 51820)

### 2️⃣ **Stop All Services**
Gracefully shuts down all running services

### 3️⃣ **Check System Status**
Shows which services are currently running

### 4️⃣ **Run Full System Test**
Tests the complete zero-knowledge flow:
- SRT generation
- Blind signature
- DIP assignment
- DAT token generation

### 5️⃣ **Start Individual Services**
Launch services one at a time for debugging

### 6️⃣ **VPN Connection Test**
Tests VPN server DAT validation with test client

### 7️⃣ **View Logs**
Information about accessing service logs

### 8️⃣ **Clean Build**
Stops services, cleans artifacts, rebuilds everything

---

## Architecture

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │
       ├──────────────────────────────────────┐
       │                                      │
       ▼                                      ▼
┌──────────────────┐                 ┌──────────────┐
│ Blind Token Svc  │                 │  DIP Service │
│   Port 3001      │                 │  Port 3003   │
└──────────────────┘                 └──────┬───────┘
       │                                     │
       │            ┌────────────────┐       │
       └───────────▶│ Enclave Sim    │◀──────┘
                    │  Port 3002     │
                    └────────┬───────┘
                             │
                             ▼
                    ┌────────────────┐
                    │  VPN Server    │
                    │  Port 51820    │
                    └────────────────┘
```

---

## System Flow

1. **Client** generates SRT (Subscription Receipt Token)
2. **Blind Token Service** signs blinded token
3. **DIP Service** assigns dedicated IP
4. **Enclave Sim** generates DAT/DRT tokens
5. **VPN Server** validates DAT and authorizes connection

---

## Manual Commands

### Start Services
```cmd
cargo run -p blind-token-service
cargo run -p enclave-sim
cargo run -p dip-service
cargo run --bin vpn-server -- --ip 192.168.1.100
```

### Test Client
```cmd
cargo run -p zkdip-client -- test
cargo run -p zkdip-client -- assign
```

### VPN Test
```cmd
cargo run --bin test-client -- --server 127.0.0.1:51820 --ip 192.168.1.100
```

---

## Environment Variables

Create `.env` file:
```env
JWT_SECRET=dev_secret_key_change_in_production
SERVER_IP=192.168.1.100
WIREGUARD_PRIVATE_KEY=<base64-key>
WIREGUARD_PORT=51820
RUST_LOG=info
```

---

## Troubleshooting

**Services won't start:**
- Check if ports are already in use
- Run "Clean Build" (Option 8)

**Can't connect to VPN:**
- Verify all services are running (Option 3)
- Check JWT_SECRET matches on server and client
- Verify IP address matches DIP assignment

**Build errors:**
- Stop all services first
- Run `cargo clean`
- Run `cargo build --workspace`

---

## Production Deployment

⚠️ **Before deploying to production:**

1. Change `JWT_SECRET` to a strong random value
2. Use proper PostgreSQL database (not development mode)
3. Enable TLS/SSL on all HTTP services
4. Configure proper firewall rules
5. Use environment-specific configuration
6. Enable comprehensive logging
7. Set up monitoring and alerting

---

## Security Notes

🔐 **Zero-Knowledge Properties:**
- Blind Token Service never sees actual subscription data
- Enclave Simulator isolates token generation
- VPN Server only validates tokens, no user tracking
- No correlation between subscription and VPN usage

---

## Support

For issues, check:
- Service logs in each terminal window
- System status (Option 3)
- Port availability: `netstat -an | findstr "3001 3002 3003 51820"`

---

**Built with Rust 🦀 | Zero-Knowledge Architecture 🔐**
