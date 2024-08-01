# BasicNft Project

This project implements a basic ERC721 NFT contract named `BasicNft`, utilizing Solidity and OpenZeppelin's libraries. It includes functionality for minting NFTs, managing fund receiver roles, and withdrawing ETH.

## Quick Start

To quickly set up and run the project, follow these steps:

. **Install Dependencies**:
Make sure you have [Foundry](https://book.getfoundry.sh/) installed. Install dependencies with:

```
git clone https://github.com/satyasai69/Foundry_Basic_Nft
cd  Foundry_Basic_Nft
forge init
forge install Cyfrin/foundry-devops --no-commit
forge build
```

Run Tests:
Execute the test suite to ensure everything works as expected:

```
forge test
```

Deploy the Contract:
Deploy the BasicNft contract to your local blockchain or a test network:

```
make deploy-anvil      # Deploy to local Anvil instance
make deploy-sepolia    # Deploy to Sepolia test network
```

Mint an NFT:
Mint an NFT on the deployed contract:

```
make mintNft-anvil      # Mint an NFT on local Anvil instance
make mintNft-sepolia    # Mint an NFT on Sepolia test network
```

Contract Overview
BasicNft.sol
The BasicNft contract is an ERC721 NFT implementation with the following features:

Main Functions
constructor(): Initializes the contract by setting the fund receiver to the contract deployer's address.

``` solidity
    constructor() ERC721("BasicNft", "BNFT") {
        FUND_RESIVER = msg.sender;
    }

```

mintNft(string memory tokenUrl) public payable: Allows users to mint a new NFT. Requires payment of MINT_PRICE (69 wei). The tokenUrl parameter is used to store the metadata URL for the minted NFT.

tokenURI(uint256 tokenId) public view override returns (string memory): Returns the metadata URL for a given token ID.

transferFundResiverShip(address newFundResiver) public OnlyFundResiver: Allows the current fund receiver to transfer the fund receiver role to a new address.

withdrawETH() public OnlyFundResiver: Allows the current fund receiver to withdraw all ETH from the contract.

# Modifiers

OnlyFundResiver: Restricts function access to only the current fund receiver.

# Custom Errors

NEED_MORE_ETH(): Raised when the sent value is not equal to the MINT_PRICE.

ONLY_FUND_RESIVER_CAN_CALL(): Raised when a non-fund receiver attempts to execute a restricted function.

INSUFFICIENT_BALANCE(): Raised if there is an attempt to withdraw when the contract balance is zero.

# Deployment Scripts

DeployBasicNft.s.sol: A Forge script for deploying the BasicNft contract. It broadcasts the deployment transaction and returns the deployed contract instance.

MintBasicNft.s.sol: A Forge script for minting an NFT using the deployed BasicNft contract. It requires the contract address and mints an NFT with a predefined token URL.

# Testing

The BasicNftTest.s.sol script contains tests for the BasicNft contract, covering:

Contract name and symbol.
Minting functionality and balance checks.
Fund receiver transfer and withdrawal functionality.
Error conditions for unauthorized access and insufficient balance.

# Makefile

The Makefile provides commands to deploy and interact with the contract on different networks:

anvil: Start a local Anvil instance.
deploy: Deploy the contract to the specified network.
deploy-anvil: Deploy the contract to a local Anvil instance.
deploy-sepolia: Deploy the contract to the Sepolia test network.
mintNft-anvil: Mint an NFT on a local Anvil instance.
mintNft-sepolia: Mint an NFT on the Sepolia test network.
Environment Variables
Create a .env file with the following content to configure network settings:

# env

```
DEFAULT_ANVIL_KEY=YOUR_ANVIL_PRIVATE_KEY
PRIVATE_KEY=YOUR_PRIVATE_KEY
SEPOLIA_RPC_URL=YOUR_SEPOLIA_RPC_URL
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_API_KEY
```

Replace placeholders with your actual keys and URLs.

For more detailed information on Foundry, visit the Foundry Book.

