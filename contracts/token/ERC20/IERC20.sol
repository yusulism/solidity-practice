pragma solidity ^0.5.2;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    
    function totalSupply() external view returns (uint256);
    function balanceOf() external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    // indexed는 이벤트 함수에서 최대 3개의 매개변수를 색인화
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}