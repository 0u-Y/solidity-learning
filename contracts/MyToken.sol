// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MyToken {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed spender, unit256 amount)


    string public name;
    string public symbol;
    uint8 public decimals; // uint8 --> 8 bit unsigned int


    // 전체 발행 수
    uint256 public totalSupply;
    
    // 누가 얼마를 가지고 있느냐
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) allowance;


    constructor(string memory _name, string memory _symbol, uint8 _decimal, uint256 _amount) {
        name = _name;
        symbol = _symbol;
        decimals = _decimal;

        // transaction
        // from, to, date, value, gas...
        _mint(_amount*10**uint256(decimals), msg.sender); //1 MT
    }

    function approve(address spender, uint256 amount) external {
        allowance[msg.sender][spender] = amount;
        emit Approval(spender, amount);
    }

    //tranferFrom 은 허락받은 사람이 호출함 -> owner를 파라미터로 받아야함이 transfer와의 차이점
    function transferFrom(address from, address to, uint256 amount) external {
        address spender = msg.sender;
        require(allowance[from][spender] >= amount, "insufficient allowance");
        allowance[from][spender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);

    }



    function _mint(uint256 amount, address owner) internal {
        totalSupply += amount;
        balanceOf[owner] += amount;

        emit Transfer(address(0), owner, amount);
    }
    
    function transfer(uint256 amount, address to) external {

        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender, to, amount);
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




    /*
    approve
    - allow spender address to send my token
    transferFOrm
    - spender :owner -> target address

    * token owner --> bank contract
    * token owner --> router contract --> bank contract
    * token owner --> router contract --> bank contract(multi contract)


    */


}