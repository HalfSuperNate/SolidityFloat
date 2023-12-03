// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Float {
    function intToFloat(int256 number, uint256 decimals) external pure returns (string memory) {
        require(decimals <= 18, "Decimals too large");
        bool isNegative = number < 0;
        uint256 absoluteValue = isNegative ? uint256(-number) : uint256(number);

        uint256 divisor = 10**decimals;
        uint256 prefix = absoluteValue / divisor;
        uint256 suffix = absoluteValue % divisor;

        string memory result = toFloat(prefix, suffix, decimals);

        if (isNegative) {
            result = string(abi.encodePacked("-", result));
        }

        return result;
    }

    function toFloat(uint256 prefix, uint256 suffix, uint256 decimals) public pure returns (string memory) {
        string memory result = string(abi.encodePacked(uintToString(prefix)));

        if (decimals > 0) {
            result = string(abi.encodePacked(result, ".", padWithZeros(uintToString(suffix), decimals)));
        }

        return result;
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

    function padWithZeros(string memory input, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(length);
        bytes memory inputBytes = bytes(input);

        uint256 i = 0;
        while (i < length - inputBytes.length) {
            buffer[i] = '0';
            i++;
        }

        for (uint256 j = 0; j < inputBytes.length; j++) {
            buffer[i] = inputBytes[j];
            i++;
        }

        return string(buffer);
    }
}
