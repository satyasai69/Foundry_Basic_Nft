//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DepolyBasicNft} from "script/DepolyBasicNft.s.sol";

contract BasicNftTest is Test {
    DepolyBasicNft depolyer;
    BasicNft basicNft;

    address bob = makeAddr("bob");
    string public constant PUG_URL =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        depolyer = new DepolyBasicNft();
        basicNft = depolyer.run();
    }

    function testNameAndSymbol() public view {
        string memory name = basicNft.name();
        string memory symbol = basicNft.symbol();

        assertEq(name, "BasicNft");
        assertEq(symbol, "BNFT");
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked("BasicNft"))
        );
    }

    function testMintAndHaveBalance() public {
        vm.prank(bob);
        basicNft.mintNft(PUG_URL);

        assertEq(basicNft.balanceOf(bob), 1);
        assert(
            keccak256(abi.encodePacked(PUG_URL)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
