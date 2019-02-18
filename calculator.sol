pragma solidity >=0.4.0 <0.6.0;

contract Calculator {
    uint result;

    function add(uint x, uint y) public {
        result = x + y;
    }

    function sub(uint x, uint y) public {
        result = x - y;
    }

    function getResult() public view returns (uint) {
        return result;
    }
}