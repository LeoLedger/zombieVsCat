pragma solidity ^0.8.25;

import "./zombiefeeding.sol";
/**
 * @title ZombieHelper
 * @dev 玩法扩展
 */
contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether;

  /**
   * @dev 级别权限
   */
  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  /**
   * @dev 所有者地址取金
   */
    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

  /**
   * @dev zb升级链上费用修改
   */
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  /**
   * @dev zb升级
   */
  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

  /**
   * @dev 玩法:zb改名
   */
  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  /**
   * @dev 玩法:zb改基因
   */
  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].dna = _newDna;
  }


  /**
   * @dev 所有zb展示
   */
  function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
