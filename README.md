# Real Estate Registry

A decentralized real estate registry built on blockchain technology using Solidity smart contracts. This project provides a transparent, immutable, and secure platform for property ownership registration, transfer, and management.

## Project Description

The Real Estate Registry is a blockchain-based solution that revolutionizes property ownership management by leveraging the transparency and immutability of distributed ledger technology. Built on the Core Testnet 2 blockchain, this smart contract system enables secure property registration, ownership transfers, and status updates while maintaining a complete audit trail of all transactions.

The system addresses critical issues in traditional real estate management including fraud prevention, ownership disputes, lack of transparency, and inefficient paper-based processes. By utilizing blockchain technology, we create a tamper-proof registry that can be accessed and verified by all stakeholders in the real estate ecosystem.

## Project Vision

Our vision is to create a globally accessible, transparent, and efficient real estate registry that eliminates fraud, reduces transaction costs, and streamlines property ownership processes. We aim to build a foundation for a trustless real estate ecosystem where property rights are universally recognized and easily transferable across borders.

**Long-term Goals:**
- Establish a global standard for blockchain-based property registration
- Integrate with government land registries and legal systems
- Enable fractional property ownership through tokenization
- Create a comprehensive ecosystem including property valuation, insurance, and financing
- Bridge the gap between traditional real estate and DeFi (Decentralized Finance)

## Key Features

### 🏠 **Property Registration**
- Register new properties with detailed information (location, area, price, owner)
- Unique property ID generation for each registered property
- Immutable registration timestamps for legal compliance
- Only authorized registrar can register new properties

### 🔄 **Ownership Transfer**
- Secure peer-to-peer property transfers with built-in escrow
- Automatic payment processing with excess refund mechanism
- Comprehensive ownership history tracking
- Smart contract-enforced transfer conditions

### 💼 **Property Management**
- Update property sale status (for sale/not for sale)
- Modify property pricing dynamically
- Owner-only access control for property modifications
- Real-time property status updates

### 🔍 **Transparency & Verification**
- Public property information lookup
- Owner property portfolio viewing
- Complete transaction history via blockchain events
- Immutable audit trail for all property actions

### 🛡️ **Security Features**
- Role-based access control (registrar, property owners)
- Reentrancy protection for financial transactions
- Input validation and error handling
- Emergency registrar change functionality

### 📊 **Analytics & Reporting**
- Total property count tracking
- Property ownership distribution
- Transaction volume monitoring
- Event-based activity logging

## Technical Architecture

### Smart Contract Functions

#### Core Functions:
1. **`registerProperty()`** - Register new properties in the system
2. **`transferProperty()`** - Transfer ownership with payment processing
3. **`updatePropertyStatus()`** - Modify property sale status and pricing

#### View Functions:
- `getProperty()` - Retrieve property details
- `getPropertiesByOwner()` - Get all properties owned by an address
- `getTotalProperties()` - Get total registered properties count

#### Administrative Functions:
- `changeRegistrar()` - Transfer registrar role (emergency use)

### Data Structures

```solidity
struct Property {
    uint256 id;
    string location;
    uint256 area;
    uint256 price;
    address owner;
    bool isForSale;
    bool exists;
    uint256 registrationDate;
}
```

### Events
- `PropertyRegistered` - New property registration
- `PropertyTransferred` - Ownership transfer completion
- `PropertyStatusChanged` - Property status/price updates

## Installation & Setup

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn package manager
- Git

### Installation Steps

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/real-estate-registry.git
cd real-estate-registry
```

2. **Install dependencies:**
```bash
npm install
```

3. **Environment setup:**
```bash
cp .env.example .env
# Edit .env file with your private key and configuration
```

4. **Compile contracts:**
```bash
npm run compile
```

5. **Run tests:**
```bash
npm test
```

6. **Deploy to Core Testnet 2:**
```bash
npm run deploy
```

## Usage

### Deploying the Contract

```bash
# Deploy to Core Testnet 2
npx hardhat run scripts/deploy.js --network core_testnet2

# Deploy to local network
npx hardhat run scripts/deploy.js --network localhost
```

### Contract Interaction Examples

```javascript
// Register a new property
await realEstateRegistry.registerProperty(
  "123 Main Street, City, State 12345",
  2500, // 2500 sq ft
  ethers.parseEther("1.5"), // 1.5 CORE
  ownerAddress
);

// Transfer property ownership
await realEstateRegistry.transferProperty(
  propertyId,
  newOwnerAddress,
  { value: ethers.parseEther("1.5") }
);

// Update property status
await realEstateRegistry.updatePropertyStatus(
  propertyId,
  true, // for sale
  ethers.parseEther("2.0") // new price
);
```

## Testing

The project includes comprehensive test coverage for all contract functions:

```bash
# Run all tests
npm test

# Run specific test file
npx hardhat test test/RealEstateRegistry.test.js

# Run tests with gas reporting
REPORT_GAS=true npm test
```

## Network Configuration

### Core Testnet 2
- **RPC URL:** https://rpc.test2.btcs.network
- **Chain ID:** 1112
- **Block Explorer:** https://scan.test2.btcs.network/
- **Native Token:** CORE

### Getting Test Tokens
1. Visit the Core Testnet 2 faucet
2. Enter your wallet address
3. Claim test CORE tokens for deployment and testing

## Security Considerations

### Implemented Security Measures:
- **Access Control:** Role-based permissions for critical functions
- **Reentrancy Protection:** Prevents recursive calls during transfers
- **Input Validation:** Comprehensive parameter checking
- **Safe Math:** Uses Solidity 0.8.x built-in overflow protection
- **Event Logging:** Complete audit trail via blockchain events

### Best Practices:
- Private keys stored securely in environment variables
- Regular security audits recommended
- Multi-signature wallet integration for high-value properties
- Emergency pause functionality for critical situations

## Future Scope

### Phase 1: Enhanced Features (Q2 2024)
- **Property Tokenization:** Enable fractional ownership through ERC-721/ERC-1155 tokens
- **Document Storage:** IPFS integration for property documents and certificates
- **Advanced Search:** Geographic and criteria-based property search functionality
- **Mobile App:** Cross-platform mobile application for property management

### Phase 2: DeFi Integration (Q3 2024)
- **Property Lending:** Collateralized lending using property as collateral
- **Yield Farming:** Stake property tokens to earn rewards
- **Insurance Protocol:** Decentralized property insurance marketplace
- **Price Oracle:** Real-time property valuation using external data feeds

### Phase 3: Ecosystem Expansion (Q4 2024)
- **Multi-Chain Support:** Deploy on Ethereum, Polygon, and other networks
- **Government Integration:** APIs for official land registry systems
- **Legal Framework:** Smart contract-based property law compliance
- **Marketplace:** Decentralized property trading platform

### Phase 4: Advanced Features (2025)
- **AI Valuation:** Machine learning-based property price prediction
- **Virtual Tours:** VR/AR integration for property viewing
- **Carbon Credits:** Environmental impact tracking and carbon offset trading
- **Social Features:** Community-driven property reviews and ratings

### Long-term Vision
- **Global Adoption:** Become the standard for property registration worldwide
- **Interoperability:** Seamless integration with existing legal and financial systems
- **Sustainability:** Carbon-neutral property transactions and green building incentives
- **Innovation Hub:** Platform for real estate technology innovation and development

## Contributing

We welcome contributions from the community! Please read our contributing guidelines and submit pull requests for any improvements.

### Development Guidelines:
1. Follow Solidity best practices and style guides
2. Write comprehensive tests for all new features
3. Update documentation for any changes
4. Ensure all tests pass before submitting PRs

### Areas for Contribution:
- Smart contract optimizations
- Frontend development
- Testing and security audits
- Documentation improvements
- Integration with other protocols

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, questions, or contributions:
- **Email:** support@realestate-registry.com
- **Discord:** [Join our community](https://discord.gg/realestate-registry)
- **GitHub Issues:** [Report bugs or request features](https://github.com/yourusername/real-estate-registry/issues)
- **Documentation:** [Comprehensive docs](https://docs.realestate-
0x1c3d6ddb5e136824b7cc20a9548787550ff7ac998e1681f847029737b181aa42
![Transactions](https://github.com/user-attachments/assets/a0edc98e-9bff-4fc1-bb48-4b1e269acbaa)
