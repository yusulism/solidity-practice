pragma solidity >=0.4.2 <0.6.0;

contract MyToken {
    mapping (address => uint256) public balanceOf;
 
    constructor(uint256 initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Not Enough Balance");               // check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to], "Balance Overflow");     // check for overflows
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }
}