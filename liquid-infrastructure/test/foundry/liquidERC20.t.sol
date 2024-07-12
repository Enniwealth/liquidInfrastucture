// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import {Test, console} from "forge-std/Test.sol";
import {LiquidInfrastructureERC20} from "../../contracts/LiquidInfrastructureERC20.sol";
import {TestERC20A} from "../../contracts/TestERC20A.sol";
import {TestERC20B} from "../../contracts/TestERC20B.sol";
import {TestERC20C} from "../../contracts/TestERC20C.sol";
contract liquidERC20 is Test {
    TestERC20A testERC20A;
    TestERC20B testERC20B;
    TestERC20C testERC20C;
    LiquidInfrastructureERC20 liquidInfrast;
    address nftAccount1 = makeAddr('nftAccount');
    address nftAccount2 = makeAddr('nftAccount2');
    address nftAccount3 = makeAddr('nftAccount3');
    address erc20Owner = makeAddr('erc20Owner');
    address holder1 = makeAddr('holder1');
    address holder2 = makeAddr('user2');
    address holder3 = makeAddr('holder3');
    address holder4 = makeAddr('holder4');
    address badSigner = makeAddr('badSigner');
    address[] distributeErc;
    
    function setUp() public 
    {
    
    address[] memory managedNFT  = new address[](0);
    address[] memory approvedHolders = new address[](0);

        vm.startPrank(erc20Owner);
        testERC20A = new TestERC20A();
        testERC20B = new TestERC20B();
        testERC20C = new TestERC20C();
        vm.stopPrank();
        address ercA = address(testERC20A);
        address ercB = address(testERC20B);
        address ercC = address(testERC20C);

        
        distributeErc = [ercA, ercB, ercC];
        liquidInfrast = new LiquidInfrastructureERC20(erc20Owner,"Infra", "INFRA", managedNFT, 500, distributeErc);

    }

    function test_return_assertion() public {
        assertEq(liquidInfrast.totalSupply(), 0);
        assertEq(liquidInfrast.name(), "Infra");
        assertEq(liquidInfrast.symbol(), "INFRA");
        assertEq(liquidInfrast.isApprovedHolder(address(holder1)), false );
        vm.expectRevert();
        liquidInfrast.mint(address(holder1), 1000);

        vm.expectRevert();
        liquidInfrast.ManagedNFTs();
        console.log(erc20Owner);
        assertEq(liquidInfrast.balanceOf(erc20Owner), 0);
    }
    function test_ownership() public {

    }



}
