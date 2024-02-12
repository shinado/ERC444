// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import "hardhat/console.sol";
import "./ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC444 is ERC20 {

    struct BurningInfo {
        address from;
        uint256 amount;
        string message;
    }

    struct Burning {
        address addr;
        string name;
        uint256 amount;
        bool exists;
    }

    mapping(address => Burning) private addressMap;
    mapping(address => BurningInfo[]) private burningMap;
    mapping(string => address) private name2Address;
    // Array to store the keys of the mapping
    address[] private addresses;

    uint256 private MAX;

    constructor(string memory _name, string memory _symbol, uint256 _maxSupply) ERC20(_name, _symbol) {
        MAX = _maxSupply;
    }

    function maxSupply() public view returns (uint256) {
        return MAX;
    }

    function _burnToAddress(
        address addr,
        uint256 amount,
        string memory message
    ) private{
        transfer(addr, amount);
        addressMap[addr].amount += amount;

        burningMap[addr].push(
            BurningInfo({from: msg.sender, amount: amount, message: message})
        );
    }

    function burnToAddress(
        address addr,
        uint256 amount,
        string memory message
    ) public {
        require(addressMap[addr].exists == true, "Address not exists");
        _burnToAddress(addr, amount, message);
    }

    function getBurningHistory(
        address addr
    ) public view returns (BurningInfo[] memory) {
        return burningMap[addr];
    }

    function burn(
        string memory recipient,
        uint256 amount,
        string memory message
    ) public returns (address) {
        address addr = stringToAddress(recipient);

        if (addressMap[addr].exists == false) {
            addressMap[addr].exists = true;
            addressMap[addr].name = recipient;
            addressMap[addr].addr = addr;
            addresses.push(addr);
        }
        _burnToAddress(addr, amount, message);

        return addr;
    }

    function getAddressByName(
        string calldata recipient
    ) public view returns (address) {
        address addr = name2Address[recipient];
        if (addr == address(0)) {
            return stringToAddress(recipient);
        }
        return addr;
    }

    function getNameByAddress(
        address addr
    ) public view returns (string memory) {
        return addressMap[addr].name;
    }

    function stringToAddress(
        string memory inputString
    ) private pure returns (address) {
        // Hash the input string
        bytes32 hash = keccak256(abi.encodePacked(inputString));

        // Convert hash and '0x44444444' to bytes
        bytes memory hashBytes = abi.encodePacked(hash);
        // bytes memory additionalString = "DDDD";
        bytes memory combinedBytes = new bytes(20);

        uint k = 0;
        for (uint i = 0; i < 4; i++) combinedBytes[k++] = "D";

        // Concatenate bytes
        // for (uint i = 0; i < additionalString.length; i++) combinedBytes[k++] = additionalString[i];
        for (uint i = 0; k < 20; i++) combinedBytes[k++] = hashBytes[i];

        // Convert the combined bytes to address
        // Note: This might not result in a valid address
        return bytesToAddress(combinedBytes);
    }

    function bytesToAddress(
        bytes memory bys
    ) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 20))
        }
    }

    function startsWith44444444(address _addr) private pure returns (bool) {
        string memory addrStr = toAsciiString(_addr);
        bytes memory prefixBytes = bytes("0x44444444");

        for (uint i = 0; i < 8; i++) {
            if (bytes(addrStr)[i] != prefixBytes[i]) {
                return false;
            }
        }
        return true;
    }

    function toAsciiString(address _addr) private pure returns (string memory) {
        bytes memory addressBytes = abi.encodePacked(_addr);
        bytes memory hexBytes = "0123456789abcdef";
        bytes memory stringBytes = new bytes(42);

        stringBytes[0] = "0";
        stringBytes[1] = "x";

        for (uint i = 0; i < 20; i++) {
            stringBytes[2 + i * 2] = hexBytes[uint8(addressBytes[i] >> 4)];
            stringBytes[3 + i * 2] = hexBytes[uint8(addressBytes[i] & 0x0f)];
        }

        return string(stringBytes);
    }

    function addressToKeccak256Hash(
        address _addr
    ) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(toAsciiString(_addr)));
    }

    function char(bytes1 b) private pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }
}
