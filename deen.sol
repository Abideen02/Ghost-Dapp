// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
  function transfer(address, 
  uint256) external returns (bool);
  function approve(address, 
  uint256) external returns (bool);
  function transferFrom(address, 
  address, 
  uint256) external returns (bool);
  function totalSupply() 
  external view returns (uint256);
  function balanceOf(address) 
  external view returns (uint256);
  function allowance(address, address) 
  external view returns (uint256);

  event Transfer(address indexed from, 
  address indexed to, uint256 value);
  event Approval(address indexed owner, 
  address indexed spender, uint256 value);
}

contract Ghostapp {

    address internal cUsdTokenAddress = 0xD5Db2CE937b15946fAC8C36Bfa477B51cC5d72a3;
    uint internal ghostLength = 0;
   
    struct Ghostproduct {
        address payable owner;
        string name;
        string image;
        string description;
        string available;
        uint price;
        uint sold;
    }

    mapping (uint => Ghostproduct) internal merch;

    function ghostwrite(
        string memory _name,
        string memory _image,
        string memory _description, 
        string memory _available, 
        uint _price
    ) public {
        uint _sold = 0;
        merch[ghostLength] = Ghostproduct(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _available,
            _price,
            _sold
        );
        ghostLength++;
    }

    function ghostread(uint _index) public view returns (
        address payable,
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint, 
        uint
    ) {
        return (
            merch[_index].owner,
            merch[_index].name, 
            merch[_index].image, 
            merch[_index].description, 
            merch[_index].available, 
            merch[_index].price,
            merch[_index].sold
        );
    }

    function ghostbuy(uint _index) public payable  {
        require(
          IERC20Token(cUsdTokenAddress).transferFrom(
            msg.sender,
            merch[_index].owner,
            merch[_index].price
          ),
          "Transfer failed. Please try again"
        );
        merch[_index].sold++;
    }
    
    function getghostLength() public view returns (uint) {
        return (ghostLength);
    }
    
}