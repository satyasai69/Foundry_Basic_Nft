//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft depolyer;
    BasicNft basicNft;

    address bob = makeAddr("bob");
    string public constant PUG_URL =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        depolyer = new DeployBasicNft();
        basicNft = depolyer.run();
        vm.deal(bob, 1 ether);
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
        basicNft.mintNft{value: 69}(PUG_URL);

        assertEq(basicNft.balanceOf(bob), 1);
        assert(
            keccak256(abi.encodePacked(PUG_URL)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    function testTransferFundResiverByFundResiver() public {
        vm.prank(msg.sender);
        basicNft.transferFundResiverShip(bob);

        assertEq(basicNft.FUND_RESIVER(), bob);
    }

    function testFailIfTransferFundResverNotFundResiver() public {
        vm.prank(bob);

        //  vm.expectRevert();
        basicNft.transferFundResiverShip(bob);
    }

    function testFundResiverWithdrawEthFunds() public {
        vm.deal(address(basicNft), 10 ether);
        vm.prank(msg.sender);
        basicNft.withdrawETH();
        assertEq(address(msg.sender).balance, 79228162524264337593543950335);
        assertEq(address(basicNft).balance, 0);
    }

    function testFailIfNotFundResverCallingWithdrawEth() public {
        vm.deal(address(basicNft), 10 ether);
        vm.prank(bob);
        //  vm.expectRevert();
        basicNft.withdrawETH();
    }
}
