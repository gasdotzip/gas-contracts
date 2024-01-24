// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/GasZip.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
    }

    function deploy(string memory rpc, address owner) internal {
        vm.createSelectFork(rpc);
        vm.startBroadcast();
        new GasZip(owner);
        vm.stopBroadcast();
    }
}
