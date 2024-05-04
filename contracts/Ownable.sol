pragma solidity ^0.8.25;
/**
 * @title Ownable
 * @dev 提供一个所有者地址，授权控制
 *
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev 所有者权限
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev 所有者权限转移
   * @param newOwner 新所有者地址
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}
