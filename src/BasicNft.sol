//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    uint256 public MINT_PRICE = 69;
    address public FUND_RESIVER;
    mapping(uint256 => string) private s_tokenidtourl;

    error NEED_MORE_ETH();
    error ONLY_FUND_RESIVER_CAN_CALL();
    error INSUFFICIENT_BALANCE();

    constructor() ERC721("BasicNft", "BNFT") {
        FUND_RESIVER = msg.sender;
    }

    modifier OnlyFundResiver() {
        if (msg.sender != FUND_RESIVER) {
            revert ONLY_FUND_RESIVER_CAN_CALL();
        }
        _;
    }

    function mintNft(string memory tokenUrl) public payable {
        if (msg.value != MINT_PRICE) {
            revert NEED_MORE_ETH();
        }
        s_tokenidtourl[s_tokenCounter] = tokenUrl;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        payable(FUND_RESIVER).transfer(msg.value);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenidtourl[tokenId];
    }

    function transferFundResiverShip(
        address newFundResiver
    ) public OnlyFundResiver {
        FUND_RESIVER = newFundResiver;
    }

    function withdrawETH() public OnlyFundResiver {
        uint256 balance = address(this).balance;
        if (balance < 0) {
            revert INSUFFICIENT_BALANCE();
        }
        payable(FUND_RESIVER).transfer(balance);
    }
}
