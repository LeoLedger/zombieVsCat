pragma solidity ^0.6.6;
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

/**
 * @title ZombieFactory
 * @dev 工厂
 */

contract ZombieFactory is VRFConsumerBase {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    bytes32 public keyHash;
    uint256 public fee;
    uint256 public randomResult;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
/**
   * @dev Random从Chainlink获取Rinkeby 网络
   */
    constructor() VRFConsumerBase(
        0x6168499c0cFfCaCD319c818142124B7A15E857ab,
        0x01BE23585060835E02B77ef475b0Cc51aA1e0709 
    ) public{
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 100000000000000000;

    }
/**
   * @dev 生产zb
   */
    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

/**
   * @dev 生产dna
   */
    function getRandomNumber() public returns (bytes32 requestId) {
        return requestRandomness(keyHash, fee);
    }
/**
   * @dev 生产Random
   */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
    }
}
