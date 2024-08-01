//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenidtourl;

    constructor() ERC721("BasicNft", "BNFT") {}

    function mintNft(string memory tokenUrl) public {
        s_tokenidtourl[s_tokenCounter] = tokenUrl;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenidtourl[tokenId];
    }
}
