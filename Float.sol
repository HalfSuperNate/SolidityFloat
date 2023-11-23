// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Float {
    function uintToFloat(uint256 number, uint256 decimals) external pure returns (string memory) {
        require(decimals <= 18, "Decimals too large");
        uint256 prefix = number / (10**decimals);
        uint256 suffix = number - (prefix * (10**decimals));
        
        return toFloat(prefix, suffix);
    }

    function toFloat(uint256 prefix, uint256 suffix) public pure returns (string memory) {
        return string(abi.encodePacked(uintToString(prefix), ".", uintToString(suffix)));
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
