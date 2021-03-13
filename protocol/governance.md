# Governance

## Role

The SMIN governance organization is responsible for:
- Upgrading proxy implementations as needed.
- Deploying new index pools.
- Managing the token categories which indices select from and creating new ones.
- Approving pool controllers that implement new management strategies.
- Setting configuration values such as swap fees.

## SMIN Token Distribution

SMIN is the governance token for Sminem Finance. The initial supply of 2,500,000 SMIN will be distributed as follows:
- 20% will be made available to the SMIN treasury over the course of 9 months, beginning March 25, 2021.
- 38% will be distributed through liquidity mining to users who stake index tokens.
- 7% will go to the founders, investors and future team members, subject to vesting periods.
- 14% will be distributed via the treasury in a manner to be determined by governance.


Minting is restricted to a maximum of 10% of the supply (at the time tokens are minted) and may only occur once every 90 days. NDX governance may also disable minting permanently by changing the minter address from the timelock contract to the null address.

## Early Governance

In order to ensure the security of the project while distribution is underway, the team will retain the ability to create and vote on governance proposals while our tokens are vesting. This will ensure that we are able to respond if security incidents occur prior to the completion of the initial distribution, but all successful proposals will still be subject to the two day time lock. Additionally, the voting period on the governor contract is temporarily set to a value which corresponds to about 12 hours in blocks; after January 7, 2021, anyone can call a function on the governor to set the voting period to its permanent value, which is closer to 3 days.
