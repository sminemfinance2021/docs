// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import './Rogue.sol';

contract Presale is Ownable {
  IERC20 public immutable ROGUE;
  uint public constant presaleSupply = 2500;
  uint public constant startDate = 1611518400;
  uint256 public constant presalePrice = 12; // 0.12 then divide by 100
  uint256 public constant maxTokensPerWallet = (10 * 10 ** 18) / presalePrice * 100; // max 10 eth worth of tokens per wallet

  constructor(Rogue rogue) public {
    ROGUE = rogue;
  }

  receive() external payable {
    require(startDate <= block.timestamp, "Presale hasn't started yet");

    uint tokensToTransfer = msg.value / presalePrice * 100;
    require(tokensToTransfer <= ROGUE.balanceOf(address(this)), "Not enough tokens in Presale contract");
    require(tokensToTransfer + ROGUE.balanceOf(address(msg.sender)) <= maxTokensPerWallet, "Max 10 eth worth of tokens allowed in presale");
    ROGUE.transfer(msg.sender, tokensToTransfer);
  }

  function withdrawProvidedEth() external onlyOwner {  // external onlyOwner
    payable(owner()).transfer(address(this).balance);
  }

  function withdrawTokemon() external onlyOwner {  // external onlyOwner
    ROGUE.transfer(owner(), ROGUE.balanceOf(address(this))); //safeTransfer?
  }

}
