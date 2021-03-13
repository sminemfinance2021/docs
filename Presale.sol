// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import './Sminem.sol';

contract Presale is Ownable {
  IERC20 public immutable SMIN;
  uint public constant presaleSupply = 550000;
  uint public constant startDate = 1611518400;
  uint256 public constant presalePrice = 12; // 0.12 then divide by 100
  uint256 public constant maxTokensPerWallet = (10 * 10 ** 18) / presalePrice * 1000; // max 10 eth worth of tokens per wallet

  constructor(SMIN Sminem) public {
    SMIN = Sminem;
  }

  receive() external payable {
    require(startDate <= block.timestamp, "Presale hasn't started yet");

    uint tokensToTransfer = msg.value / presalePrice * 1000;
    require(tokensToTransfer <= SMIN.balanceOf(address(this)), "Not enough tokens in Presale contract");
    require(tokensToTransfer + SMIN.balanceOf(address(msg.sender)) <= maxTokensPerWallet, "Max 10 eth worth of tokens allowed in presale");
    SMIN.transfer(msg.sender, tokensToTransfer);
  }

  function withdrawProvidedEth() external onlyOwner {  // external onlyOwner
    payable(owner()).transfer(address(this).balance);
  }

  function withdrawTokemon() external onlyOwner {  // external onlyOwner
    SMIN.transfer(owner(), SMIN.balanceOf(address(this))); //safeTransfer?
  }

}
