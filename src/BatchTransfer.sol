pragma solidity ^0.4.21;

interface Token {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract BatchTransfer {
    address public owner;
    address public admin;
    Token public token;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyOwnerOrAdmin {
        require(msg.sender == owner || msg.sender == admin);
        _;
    }

    constructor(address _tokenAddr) public {
        owner = msg.sender;
        token = Token(_tokenAddr);
    }

    function ownerSetOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function ownerSetAdmin(address newAdmin) public onlyOwner {
        admin = newAdmin;
    }

    function ownerTransfer(address _addr, uint256 _value) public onlyOwner {
        token.transfer(_addr, _value);
    }

    function executeBatchTransfer(address[] _dests)
        public
        onlyOwnerOrAdmin
        returns (uint256)
    {
        uint256 i = 0;
        while (i < _dests.length) {
            token.transfer(_dests[i], 1000000000000000000);
            i += 1;
        }
        return i;
    }
}
