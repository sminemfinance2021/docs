# Removing Tokens

If a token in an index pool has a target weight of zero, the pool should remove the token from its portfolio. This is done gradually through the rebalancing process until the token reaches the minimum weight.

When a token's weight reaches the minimum (roughly 1%), the price changes that occur as the result of swaps become more dramatic and begin to expose the pool to unintended loss. Rather than continuing the gradual weight adjustment until the token is completely gone, once a token reaches the minimum weight the pool will transfer the remaining balance to an *unbound token handler* contract which is deployed for each pool.

Additionally, if the `gulp` function on a pool is called for a token which is not bound to the pool, the pool's balance of that token will be sent to the unbound token handler.

## Handling Unbound Tokens

Currently, the only contract for handling unbound tokens is [UnboundTokenSeller.sol](../../smart-contracts/token-seller.md). A new unbound token seller contract is deployed as a proxy for each index pool. The contract receives unbound tokens from a pool and sells them for the desired underlying tokens in the pool (tokens with a non-zero target weight).

### Token Pricing

The token seller uses the PancakeSwap oracles to determine the hourly moving average prices of tokens being swapped. It is configured with a `premiumPercent` value that gives an advantage to token buyers by reducing the output value it expects for a given input value.

Example: if the seller has `premiumPercent = 5` and owns 10 A tokens with an average price of 1 BNB on PancakeSwap, and someone wants to purchase them for B tokens with an average price of 2 BNB on PancakeSwap, the contract will accept 4.75 B (worth 9.5 BNB) for 10 A (worth 10 BNB).

### PancakeSwap Trades

Users can call the contract to trigger a PancakeSwap trade between a token it holds and a token the pool will accept. For PancakeSwap trades, any output tokens the contract receives beyond the minimum are paid to the caller as a reward for triggering the swap.

### User Trades

Users can call the contract to trade with it directly. For these trades, the contract will always take the minimum output or pay the maximum input, depending on whether the user calls to swap an exact input or output amount.
