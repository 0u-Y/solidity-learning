// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals; // uint8 --> 8 bit unsigned int


    // 전체 발행 수
    uint256 public totalSupply;
    
    // 누가 얼마를 가지고 있느냐
    mapping(address => uint256) public balanceOf;


    constructor(string memory _name, string memory _symbol, uint8 _decimal) {
        name = _name;
        symbol = _symbol;
        decimals = _decimal;

        // transaction
        // from, to, date, value, gas...
        _mint(1*10**uint256(decimals), msg.sender); //1 MT
    }



    function _mint(uint256 amount, address owner) internal {
        totalSupply += amount;
        balanceOf[owner] += amount;
    }

    //function totalSupply() external view returns (uint256) {
    //    return totalSupply;
    //}

    //function balanceOf(address _owner) external view returns (uint256) {
    //    return balanceOf[_owner];
    //}

    //function name() external view returns (string memory) {
    //    return name;
    //}


}