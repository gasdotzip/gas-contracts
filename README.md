<p align="center">
 <img width="100px" src="https://www.gas.zip/gasLogo400x400.png" align="center" />
 <h3 align="center">Gas.zip Gas Reloader</h3>
 <p align="center">Instant bulk gas reloader supporting over 200+ chains.</p>
</p>

### Overview

The Gas.zip gas refuel bridge supports over 200+ destination chains and 18 source chains. The primary function from a users perspective will be depositing, where you send the Gas.zip deposit contract some amount of the native source chain asset and it will be divided up among your desired destination chains.  All software is licensed under MIT and is verified on-chain at the [respective addresses](https://dev.gas.zip/gas/chain-support/inbound). 

Additional documentation and implementations can be found at [https://dev.gas.zip](https://dev.gas.zip). 

### Depositing to Gas.zip

Each inbound source chain has a deposit contract deployed that can accept any amount of the chains native inbound currency (ETH, AVAX, BNB, MATIC) between $1.00 USD and $50.00 USD. Gas uses the CoinGecko API for real-time coin price calculations.

**WARNING:** Do not send less than $1.00 USD or more than $50.00 USD **PER CHAIN** to the deposit() function. Please contact us in [Discord](https://discord.gg/gasdotzip) via a support ticket if you have accidentally done so.

To call the `deposit()` function, you must supply a list of destination chain IDs and a destionation address you desire to recieve the outbound funds. The destination address does not have to be the same address sending the inbound source transaction. The destination chain IDs are **not** the native chain IDs of each blockchain, they are internal chain IDs designated by Gas.zip. Please see [Chain Support](https://dev.gas.zip/gas/chain-support/outbound)  this list of chain IDs.

### Mutiple Destination Chains

To deposit to mutiple destination chains at once, you will need to add the destination chain IDs as `unit8`s into a single `unit256`. If you wanted to send to zkSync `51`, Polygon zkEVM `52`, Zora `56` and Gnosis `16`, you would convert it in the following manner:

```tsx [typescript]
const chainsBN = [51, 52, 56, 16].reduce((p, c) => (p << BigInt(8)) + BigInt(c), BigInt(0))

// The result of this function is `859060240n`,
// which you would pass into the `chains` field in the `deposit()` function.
```

```python [python]
gas_zip_short_chain_ids = [51, 52, 56, 16]
chains_bn = sum(chain << (8 * i) for i, chain in enumerate(gas_zip_short_chain_ids))

# The result of this function is 272118835,
# which you would pass into the chains field in the deposit() function.
```

### Code Example for `deposit()`

Below is an example implementation for calling the `deposit()` function.

```ts twoslash [viem]
import { parseEther, http, createWalletClient, publicActions } from 'viem'
import { privateKeyToAccount } from 'viem/accounts'
import { optimism } from 'viem/chains'
import { depositABI } from './depositABI'

// Create a wallet from a private key
const account = privateKeyToAccount('0x...')

// Connect the wallet to a provider
const client = createWalletClient({
  account,
  chain: optimism, // Target Chain
  transport: http(),
}).extend(publicActions)

// Replace with address you want to send funds to
const toAddress = account.address

// Each chain will receive an equal portion of the value sent
const amount: bigint = parseEther('0.0006')

// This example is targeting zkSync (51), Polygon zkEVM (52)
const gasZipShortChainIDs = [51, 52]

// Prepare targeted chains parameter for deposit()
const chainsBN = gasZipShortChainIDs.reduce((p, c) => (p << BigInt(8)) + BigInt(c), BigInt(0))
;(async () => {
  // Prepare the contract write configuration
  const { request } = await client.simulateContract({
    address: '0x9e22ebec84c7e4c4bd6d4ae7ff6f4d436d6d8390', // Targeting Gas.zip Optimism Contract
    abi: depositABI,
    functionName: 'deposit',
    value: amount,
    args: [chainsBN, toAddress],
  })

  // Call the deposit() function
  await client.writeContract(request)
})()

export const depositABI = [
  {
    inputs: [
      {
        internalType: 'uint256',
        name: 'chains',
        type: 'uint256',
      },
      {
        internalType: 'address',
        name: 'to',
        type: 'address',
      },
    ],
    name: 'deposit',
    outputs: [],
    stateMutability: 'payable',
    type: 'function',
  },
] as const
```

### Questions & Contact 

Please feel free to ask questions in the Gas.zip [Discord channel](https://discord.gg/gasdotzip) or DM us on [Twitter](https://twitter.com/gasdotzip). 
